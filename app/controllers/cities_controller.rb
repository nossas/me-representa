class CitiesController < ApplicationController
	layout "merepresentalogged"
	respond_to :json

    def index
		@match = params['match']
		@cidades = City.where("name ilike '#{@match}%'")
		@cid = @cidades.map{|c| [c.id, "#{c.name}, #{c.state}"]}
		render :json => @cid
	end

	def convine
		@city = City.find params[:id]
        @current_user = current_user
    end
    
    def candidates
        @current_user = User.find session[:user_id]
        @candidates =  Candidate.
                joins("inner join answers on (answers.responder_id = candidates.id) and (answers.responder_type = 'Candidate')").
                where("answers.short_answer = 'Sim' and candidates.finished_at is not null and candidates.city_id = #{params[:id]}").
                group("candidates.id").
                order("count(*) desc").
                limit(10)
        redirect_to city_convine_url(params[:id]) if @candidates.count == 0 
    end
end

