
class MainController < ApplicationController
    layout "merepresentaunlogged"
    
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
                redirect_to new_answer_path;
            end
        end
    end
    
    def about
    end
end