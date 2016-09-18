#coding: utf-8
class UsersController < ApplicationController
  layout "merepresentalogged"

  inherit_resources
  load_and_authorize_resource

  before_filter :load_all_cities, only:[:edit]

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to params[:redirect_to] || new_answer_path }
      failure.html
    end
  end

  def matchup_data
    render :json => get_match_data(params[:list])
  end

  def matchup
    @user = User.find params[:user_id]
    @matdata = @user.matches
    if (@matdata.size == 0)
      redirect_to city_convine_path(@user.city_id)
    else
      @matching = get_match_data @matdata.slice(0,6).map{|dt| dt[:id]}
      @matdata = @matdata.slice( 6, @matdata.count) || []
    end
  end

  private

  def get_match_data candidate_list
    candidate_list.map { |id| Candidate.find id }.map {|can| {
        :id => can.id,
        :picture => can.picture,
        :nickname => can.nickname,
        :number => can.number,
        :union => can.party_union ? can.party_union.name : nil ,
        :party_symbol => can.party.symbol,
        :vote_intension => can.vote_intension
      }}
  end

  def load_all_cities
    @cities = City.cities_for_select
  end
end
