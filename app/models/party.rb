class Party < ActiveRecord::Base
  attr_accessible :number, :symbol, :union_id, :union
  validates :number, :symbol, :uniqueness => true
  belongs_to :union
end
