class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id
  validates :name, :nickname, :number, :token, :uniqueness => true
  validates :name, :nickname, :number, :party_id, :presence => true
  before_create { self.token = Digest::SHA1.hexdigest Time.now.to_s }
end
