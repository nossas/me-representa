class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  has_many :answers, :as => :responder

  belongs_to :candidate
  belongs_to :city
  
  validates_presence_of :email, :name

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

  def matches(first_record = 0, quantity = 10)
    Candidate.
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
        ) as score
        , candidates.id
        , candidates.name
        , parties.symbol as party_symbol
        , (select u.name from parties_unions pu inner join unions u on pu.union_id = u.id where pu.party_id = candidates.party_id and u.city_id = candidates.city_id) as union 
        }).
     joins(:party).
     where("candidates.finished_at is not null and candidates.city_id = #{city_id}").
     offset(first_record).
     limit(quantity).
     order("2 desc")
  end

  private

  def corrige_dados
    self.mobile_phone.gsub! /\D/, '' if self.mobile_phone  != nil
  end
end
