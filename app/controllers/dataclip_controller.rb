class DataclipController < ApplicationController
	layout "merepresentaunlogged"

	def responderam
		if params[:city_id]
			@city_id = params[:city_id]
			@candidates = TseData.where("city_id = #{@city_id} and cpf not in (select c.cpf from candidates c where c.city_id = #{@city_id})")
			respond_to do |format| 
				format.xml {
					render :xml => @candidates, :except=>[:cpf, :born_at, :created_at, :updated_at, :city_id, :party_id], :include=>{:city=>{:only=>[:name, :state]}, :party=>{:only=>[:number, :symbol]}}
				}
				format.json {
					render :json => @candidates, :except=>[:cpf, :born_at, :created_at, :updated_at, :city_id, :party_id], :include=>{:city=>{:only=>[:name, :state]}, :party=>{:only=>[:number, :symbol]}}
				}
				format.csv {
					render csv: @candidates
				}
				format.html
			end
		end
	end
end