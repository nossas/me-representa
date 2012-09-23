class Like < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :user
  # attr_accessible :title, :body
end
