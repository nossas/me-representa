#coding: utf-8
class UsersController < ApplicationController
  layout "application_phase_two" 

  inherit_resources
  load_and_authorize_resource

  # Se existir um candidato para o usuário, vai carregar também
  # Leva em consideração que o ID do candidato = ID do usuário
  before_filter only:[:edit] do
    if Candidate.exists? @user.id
      @candidate = Candidate.find @user.id
    else
      @candidate = Candidate.new
      @candidate.id = @user.id
      @candidate.name = @user.name
      @candidate.email = @user.email
      @candidate.mobile_phone = @user.mobile_phone
      @candidate.city_id = @user.city_id
    end
  end

  before_filter :load_all_cities, only:[:edit]

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end

  def update
    update! { redirect_to :back and return }
  end

  private

  def load_all_cities
    @cities = City.all.map {|c| ["#{c.name}, #{c.state}", c.id]}
  end
end
