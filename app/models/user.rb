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
    match_data = Candidate.
      select(
        %Q{
          (
            select
                count(*)
              from 
                answers ca 
                inner join
                  answers ua
                  on (ua.responder_id = #{id}) and (ca.question_id = ua.question_id) and (ua.responder_type = 'User') and (ua.weight>0)
              where 
                ca.responder_id = candidates.id and ca.responder_type='Candidate' and ca.short_answer = 'Sim'
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

  private

  def corrige_dados
    self.mobile_phone.gsub! /\D/, '' if self.mobile_phone  != nil
  end

  def ranking( dt )
    (dt[:score_final] >= 9.8 ) ? 3 :
    (dt[:score_final] >= 5.6 ) ? 2 : 1
  end
end
