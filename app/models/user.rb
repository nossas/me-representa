class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  validates_presence_of :email, :name

  def self.create_from_hash!(hash)
    create(
          :email => hash['email'],
          :name => "#{hash['first_name']} #{hash['last_name']}",
          :picture => hash['image_url']
          )
  end
end
