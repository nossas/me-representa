class DataclipController < ApplicationController
	layout "merepresentaunlogged"

	def responderam
		if params[:city_id]
			@city_id = params[:city_id]
			@city = City.find @city_id
			@candidates = Candidate.
				where("city_id = #{@city_id}").
				order(:party_id, :name).
				map {|c| {
						:id => c.id,
						:nickname => c.nickname,
						:party_id => c.party_id,
						:party => c.party.symbol,
						:number => c.number,
						:email => (User.find c.id).email,
						:city => c.city.name,
						:state => c.city.state,
						:finished => c.finished_at == nil ? "Não" : "Sim"
					}}
			
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

	def nresponderam
		if params[:city_id]
			@city_id = params[:city_id]
			@city = City.find @city_id
			@candidates = TseData.
				where("city_id = #{@city_id} and cpf not in (select c.cpf from candidates c where c.city_id = #{@city_id})").
				order("tse_data.party_id, tse_data.name")
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