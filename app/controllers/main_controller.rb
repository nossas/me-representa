
class MainController < ApplicationController
    layout "merepresentalogged"

    include LoggedHelper;

    before_filter :load_logged, :except => [:index]
    
    skip_authorization_check

    def index
        if session[:candidate_id]
            candidate_id = session[:candidate_id]
            if not Candidate.exists? candidate_id
                reset_session
                redirect_to(root_path)
            else
                candidate = Candidate.find candidate_id
                if candidate.finished_at
                    redirect_to candidate_path(candidate_id)
                else
                    redirect_to(edit_candidate_path(candidate_id))
                end
            end
        elsif session[:user_id]
            if not User.exists? session[:user_id]
                reset_session
                redirect_to(root_path)
            else
                user = User.find session[:user_id]
                if user.city_id 
                    redirect_to new_answer_path;
                else
                    redirect_to edit_user_path(user);
                end
            end
        else
            render layout: "merepresentaunlogged"
        end
    end
    
    def about
    end

    def criteria
        
    end
end