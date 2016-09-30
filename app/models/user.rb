class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  has_many :answers, :as => :responder

  belongs_to :candidate
  belongs_to :city
  
  validates_presence_of :email, :name, :city_id

  before_save :corrige_dados
  before_create :corrige_dados

  attr_accessible :candidate_id, :email, :name, :picture, :mobile_phone, :city_id

  def self.create_from_hash!(hash)
    user = User.new
    if hash['info']['email']
      user.email = hash['info']['email']
      user.email_validated = true
    else
      user.email = ''
      user.email_validated = false
    end
    user.name = "#{hash['info']['name']}"
    user.picture =hash['info']['image_url'] || hash['info']['image']
    user.save(:validate => false)
    user
  end

  def percent_care(qtde)
    qtde * 100 / answers.select{|a| a.weight > 0}.count
  end


  def matches
    ors = answers.select{|a| a.weight > 0}.map{|a| "ca.question_id = #{a.question_id}"}.join(" or ")
    ors = "1==1" if (ors == '')
    match_data = Candidate.
      select(
        %Q{
          (
            select
                count(*)
              from 
                answers ca 
              where 
                ca.responder_id = candidates.id and ca.responder_type='Candidate' and ca.short_answer = 'Sim' and 
                (#{ors})
          ) as score_eleitor
          ,(
            select
                count(*)
              from 
                answers ca 
              where 
                ca.responder_id = candidates.id and ca.responder_type='Candidate' and ca.short_answer = 'Sim'
          ) as score_direitos_humanos
          , candidates.nickname
          , candidates.id as id
          , (select u.score from parties_unions pu inner join unions u on pu.union_id = u.id where pu.party_id = candidates.party_id and u.city_id = candidates.city_id limit 1) as union_score
          , parties.score as party_score
          , (select count(*) from users us where us.candidate_id = candidates.id) as votos 
        }).
      joins(:party).
      where("candidates.finished_at is not null and candidates.city_id = #{city_id}").
      select { |dt| dt.score_direitos_humanos.to_i > 0 }

    match_data.map do |dt|
      {
        :id => dt.id.to_i,
        :score_final => dt.score_direitos_humanos.to_i * (dt.union_score ? dt.union_score.to_f : dt.party_score.to_f),
        :comp_score =>( dt.union_score ? dt.union_score.to_f : dt.party_score.to_f),
        :party_score => dt.party_score.to_f ,
        :score => dt.score_eleitor.to_i,
        :shuffler => Random.rand(1000)
      }
    end.sort { |a,b| 
      (ranking(a) != ranking(b) ) ? ranking(a) - ranking(b) : 
      (a[:shuffler] - b[:shuffler])
    }.reverse
  end


  def self.subscribe_all
    lista_segmentos = segment_list
    cidades = City.joins("inner join candidates on (candidates.city_id = cities.id) group by cities.id having count(*) > 1")

    usuarios = User.where("id not in (select id from candidates) and city_id is not null")
    usuarios.each{ |u|

        alvo = ''
        if u.candidate_id == nil
          if (cidades.select{|c| c.id == u.city_id}.count > 0 )
            alvo = :sem_candidato
          else
            alvo = :sem_candidato_na_cidade
          end
        elsif u.city.name == 'São Paulo' and u.city.state == 'SP'
          alvo = :sampa
        elsif u.city.name == 'Rio de Janeiro' and u.city.state == 'RJ'
          alvo = :rio
        elsif u.city.name == 'Porto Alegre' and u.city.state == 'RS'
          alvo = :poa
        elsif u.city.name == 'Recife' and u.city.state == 'PE'
          alvo = :recife
        else
          alvo = :brasil
        end

        e1_2 = u.email.strip.downcase
        merge_fields = nil
        if alvo == :sem_candidato or alvo == :sem_candidato_na_cidade
          merge_fields = {
            CIDADE: u.city ? "#{u.city.name}" : '',
            UF: u.city ? "#{u.city.state}" : '',
            FNAME: u.name,
            NOME: u.name
          }
        else
          merge_fields = {
            CIDADE: u.city ? "#{u.city.name}" : '',
            UF: u.city ? "#{u.city.state}" : '',
            FNAME: u.name,
            NOME: u.name,
            NOME_URNA: u.candidate.nickname,
            NUMERO: u.candidate.number,
            PARTIDO: u.candidate.party ? u.candidate.party.symbol : ''
          }
        end

        begin
          api_client.lists(list_id).members(Digest::MD5.hexdigest(e1_2)).upsert(body: {
              email_address: e1_2,
              status: :subscribed,
              merge_fields: merge_fields
            })
            api_client.lists(list_id).segments(lista_segmentos[alvo]).members.create body:{email_address: e1_2, status: :subscribed}
        rescue Exception => e
          logger.error(e)
        end
      }   
  end

  private

  def self.segment_list
    r = api_client.lists(list_id).segments.retrieve['segments']
    
    hash_segmentos = {
      sampa: insert_or_identify_segment(r, /^e_001/ , 'e_001 - Lista de eleitores COM CANDIDATO de SÃO PAULO'),
      rio: insert_or_identify_segment(r, /^e_002/ , 'e_002 - Lista de eleitores COM CANDIDATO de RIO DE JANEIRO'),
      poa: insert_or_identify_segment(r, /^e_003/ , 'e_003 - Lista de eleitores COM CANDIDATO de POA (PORTO ALEGRE)'),
      recife: insert_or_identify_segment(r, /^e_004/ , 'e_004 - Lista de eleitores COM CANDIDATO de RECIFE'),
      brasil: insert_or_identify_segment(r, /^e_005/ , 'e_005 - Lista de eleitores COM CANDIDATO de RESTANTE DO BRASIL'),
      sem_candidato: insert_or_identify_segment(r, /^e_006/ , 'e_006 - Lista de eleitores SEM CANDIDATO'),
      sem_candidato_na_cidade: insert_or_identify_segment(r, /^e_007/ , 'e_007 - Lista de eleitores SEM CANDIDATO NA CIDADE')
    }
  end

  def self.insert_or_identify_segment segmentos, match, titulo
    id = ''
    ss =  segmentos.select{|s| s['name'].match(match) }
    if ss.count == 0
      begin
        id = api_client.lists(list_id).segments.create(body: { name: titulo, static_segment: [] })['id']
      rescue Exception => e
        logger.error(e)
      end
    else
      id = ss[0]['id']
    end
    id
  end

  def self.api_client
    Gibbon::Request.new
  end

  def self.list_id
     # "845d564a12"
     # ENV['MAILCHIMP_LIST_ID']    
     "56203dedd8"
  end

  def corrige_dados
    self.mobile_phone.gsub! /\D/, '' if self.mobile_phone  != nil
  end

  def ranking( dt )
    (dt[:score_final] >= 9.8 ) ? 3 :
    (dt[:score_final] >= 5.6 ) ? 2 : 1
  end
end
