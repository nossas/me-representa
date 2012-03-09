class User < ActiveRecord::Base
  has_many :questions
  validates_presence_of :email
end
