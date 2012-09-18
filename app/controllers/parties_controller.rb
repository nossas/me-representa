class PartiesController < ApplicationController
  layout 'application_phase_two'
  inherit_resources
  before_filter :only => [:index] do 
    @matching = Party.unrelated.match_for_user(current_user.id)
    @matching = @matching.concat Union.match_for_user(current_user.id)
    @matching.sort! {|x, y| x[:score].to_i <=> y[:score].to_i}
  end
end
