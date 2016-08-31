class CitiesController < ApplicationController
	layout "application_phase_two"
	respond_to :json

	def index
		@match = params['match']
		@cidades = City.where("name ilike '#{@match}%'")
		@cid = @cidades.map{|c| [c.id, "#{c.name}, #{c.state}"]}
		render :json => @cid
	end

	def convine
		@city = City.find params[:id]
	end
end