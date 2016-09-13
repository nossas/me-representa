#coding: utf-8
class UsersController < ApplicationController
  layout "merepresentalogged"

  inherit_resources
  load_and_authorize_resource

  # Se existir um candidato para o usuário, vai carregar também
  # Leva em consideração que o ID do candidato = ID do usuário
#  before_filter only:[:edit] do
#    if defined?(@candidate).nil?
#      if Candidate.exists? @user.id
#        @candidate = Candidate.find @user.id
#      else
#        @candidate = flash[:candidate] # Se houve erro, será retornado aqui (Edição anterior)
#
#        if @candidate == nil # Caso não seja erro, precisamos de dados novos para serem utilizados
#          @candidate = Candidate.new
#          @candidate.name = @user.name
#          @candidate.email = @user.email
#          @candidate.mobile_phone = @user.mobile_phone
#          @candidate.city_id = @user.city_id
#        end
#      end
#    end
#  end


  before_filter :load_all_cities, only:[:edit]

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to new_answer_path }
      failure.html
    end
  end

  def matchup
    @user = User.find params[:user_id]
    if params[:first] 
      @mathing = @user.matches params[:first] 
    else
      @mathing = @user.matches
    end
    p @mathing
    respond_to do |format|
      format.html
      format.json {
        render :json => @mathing.map{|val| {
            :id => val["id"], :name => val["name"], :score => @user.percent_care(val["score"].to_i), 
            :party_symbol => val["party_symbol"], :union => val["union"]} }
      }
    end
  end

  private

  def load_all_cities
    @cities = City.cities_for_select
  end
end
