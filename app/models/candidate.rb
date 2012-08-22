class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id
end
