class Like < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :candidate

  attr_accessible :candidate_id
end

