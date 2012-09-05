class Party < ActiveRecord::Base
  attr_accessible :number, :symbol, :union_id, :union
  validates :symbol, :uniqueness => true
  belongs_to :union
end
