class PartiesController < ApplicationController
  layout 'application_phase_two'
  inherit_resources
  before_filter :only => [:index] do 
    @matching = Party.unrelated.match_for_user(params[:user_id])
    @matching = @matching.concat Union.match_for_user(params[:user_id])
    @matching = @matching.sort{|x, y| y["score"].to_i <=> x["score"].to_i}
  end
end
