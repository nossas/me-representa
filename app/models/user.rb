class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  validates_presence_of :email

  def self.create_from_hash!(hash)
    create(:email => hash['info']['email'], :name => hash['info']['first_name'], :picture => hash['info']['image_url'])
  end
end
