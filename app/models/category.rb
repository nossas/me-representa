class Category < ActiveRecord::Base
  has_many :questions
  validates :name, :uniqueness => true
end
