class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  has_many :answers, :as => :responder

  belongs_to :candidate

  validates_presence_of :email, :name

  attr_accessible :candidate_id, :email, :name, :picture

  def self.create_from_hash!(hash)
    create(
          :email => hash['info']['email'],
          :name => "#{hash['info']['first_name']} #{hash['info']['last_name']}",
          :picture => hash['info']['image_url'] || hash['info']['image']
          )
  end
end
