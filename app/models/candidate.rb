class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id, :party, :email, :mobile_phone, :bio
  validates :number, :token, :uniqueness => true
  validates :name, :number, :party_id, :bio, :presence => true
  belongs_to :party
  has_many :answers, :as => :responder
  before_create { self.token = Digest::SHA1.hexdigest Time.now.to_s }
end
