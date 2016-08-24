class User < ActiveRecord::Base
  has_many :questions
  has_many :authorizations
  has_many :answers, :as => :responder

  belongs_to :candidate
  belongs_to :city
  
  validates :mobile_phone, length: { in: 8..11 }, numericality: { only_integer: true }, allow_blank: true
  validates_presence_of :email, :name

  before_save :corrige_dados
  before_create :corrige_dados

  attr_accessible :candidate_id, :email, :name, :picture, :mobile_phone, :city_id

  def self.create_from_hash!(hash)
    create!(
          :email => hash['info']['email'],
          :name => "#{hash['info']['name']}",
          :picture => hash['info']['image_url'] || hash['info']['image']
          )
  end

  private

  def corrige_dados
    self.mobile_phone.gsub! /\D/, '' if self.mobile_phone  != nil
  end
end
