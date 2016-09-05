class PartiesController < ApplicationController
    layout 'merepresentalogged'
    
    inherit_resources
    load_and_authorize_resource

    before_filter :only => [:index] do 
        @user = User.find params[:user_id]
        if (@user.answers.select{|c| c.weight > 0}).count == 0
            redirect_to city_candidates_url(@user.city_id)
        else
            @matching = Party.unrelated.match_for_user(@user.id)
            @matching = @matching.concat Union.match_for_user(@user.id)
            @matching = @matching.sort{|x, y| y["score"].to_i <=> x["score"].to_i}
            redirect_to city_convine_url(@user.city_id) if @matching.count == 0 
        end
    end
end
