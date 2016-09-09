class TseData < ActiveRecord::Base
	belongs_to :city
	belongs_to :party
	attr_accessible :born_at, :city_id, :cpf, :male, :number, :party_id, :electoral_title
end
