class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id, :party, :email, :mobile_phone, :bio, :finished_at, :group_id, :short_url, :politician, :occupation, :scholarity, :city_id, :cpf, :electoral_title

  validates :nickname, :email, :number, :party_id, :cpf, :born_at, :city_id, :presence => true
  validate :verify_tse_data

  belongs_to :party
  belongs_to :city
  
#  has_one :union, :through => :party
  has_many :answers, :as => :responder
  has_many :users
  before_create { self.token = Digest::SHA1.hexdigest("#{Time.now.to_s}#{self.number}") }
 
  scope :by_age,          ->(start, end_at) { where(['EXTRACT(year from current_date) - EXTRACT(year from born_at) 
                                                      BETWEEN ? AND ?', start, end_at]) }
  scope :by_gender,       ->(*genders)      { where(male: genders)            } 
  scope :by_scholarity,   ->(*scholarities) { where(scholarity: scholarities) }
  scope :by_reelection,   ->(*politicians)  { where(politician: politicians)  }

  scope :finished, where('finished_at IS NOT NULL')

  before_save :corrige_dados
  before_create :corrige_dados

  def self.assign_next_group candidate
    if candidate && candidate.group_id.nil?
      if Candidate.where(:group_id => 1).count <= Candidate.where(:group_id => 2).count
        candidate.update_attribute :group_id, 1
      else
        candidate.update_attribute :group_id, 2
      end
    end
  end

  def self.match_for_user user_id, options = {:party_id => nil, :union_id => nil}
    candidates = 
      Candidate.
      select("candidates.id, parties.symbol as symbol, name, nickname, round(sum((
             CASE 
             WHEN answers.short_answer = ua.short_answer 
              THEN 100 
             WHEN ua.short_answer IS NULL 
              THEN NULL
             WHEN answers.short_answer IS NULL
              THEN NULL ELSE 0 END)::numeric * ua.weight)::numeric / (CASE sum(ua.weight) WHEN 0 THEN 1 ELSE sum(ua.weight) END)) as score").
      joins(:answers).
      joins(:party).
      joins("LEFT JOIN answers ua ON ua.question_id = answers.question_id AND ua.responder_type = 'User'").
      where("ua.responder_id = ?", user_id)
    if options[:party_id] then candidates = candidates.where(:party_id => options[:party_id]) end
    if options[:union_id] then candidates = candidates.where("parties.union_id = ?", options[:union_id]) end
    connection.select_all(candidates.order("score DESC").group("candidates.name, candidates.nickname, candidates.id, symbol"))
  end

  def gang
    partidos = "tse_data.party_id = #{party_id}"
    if union
      partidos = union.parties.map {|p|  "tse_data.party_id = #{p.id}"}.reduce{|a,b| "#{a} or #{b}"}
    end
    TseData.joins(:party)
      .where("tse_data.city_id = #{city_id} and tse_data.male='true' and (#{partidos})")
      .order("(100 - extract(year from age(tse_data.born_at))) * parties.score, parties.score")
      .limit(10)
  end

  def union
    u = Union.joins(:parties).where("parties.id = #{party_id} and unions.city_id = #{city_id}")
    u[0]
    u.count>0?u[0]:nil
  end

  def verify_tse_data
      # registros = TseData.where("cpf = ? and \"number\" = ? and city_id = ? and born_at = ?", cpf, number, city_id, born_at )
      _cpf = cpf.gsub /\D/, ''
      registros = TseData.where("cpf = ? and born_at = ?", _cpf, born_at )
      errors.add(:cpf, "Dados passados não correspondem aos dados fornecidos pelo TSE") if (registros == [])
  end

  def rank
      return 4;
  end
        
  def picture
      (User.find id).picture
  end
        
  private

  def corrige_dados
    self.mobile_phone.gsub! /\D/, '' if self.mobile_phone != nil
    self.cpf.gsub! /\D/, '' if self.cpf != nil
    self.electoral_title.gsub! /\D/, '' if self.electoral_title != nil
  end
end
