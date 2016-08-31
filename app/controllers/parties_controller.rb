class PartiesController < ApplicationController
  layout 'application_phase_two'
  inherit_resources

  before_filter :only => [:index] { @user = User.find(params[:user_id]) }
  before_filter :only => [:index] do 
    @matching = Party.unrelated.match_for_user(@user.id)
    @matching = @matching.concat Union.match_for_user(@user.id)
    @matching = @matching.sort{|x, y| y["score"].to_i <=> x["score"].to_i}
    redirect_to city_convine_url(@user.city_id) if @matching.count == 0 
  end
end
