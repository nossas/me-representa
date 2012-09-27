class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  has_many :answers, :as => :responder

  belongs_to :candidate
  validates :mobile_phone, length: { in: 8..10 }, numericality: { only_integer: true }, allow_blank: true
  validates_presence_of :email, :name

  attr_accessible :candidate_id, :email, :name, :picture, :mobile_phone

  def self.create_from_hash!(hash)
    create!(
          :email => hash['info']['email'],
          :name => "#{hash['info']['first_name']} #{hash['info']['last_name']}",
          :picture => hash['info']['image_url'] || hash['info']['image']
          )
  end
end
