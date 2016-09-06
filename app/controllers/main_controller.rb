
class MainController < ApplicationController
    layout "merepresentaunlogged"
    
    skip_authorization_check
    
    def index
        if session[:candidate_id]
            candidate = Candidate.find session[:candidate_id]
            if candidate.finished_at
                redirect_to candidate_path(candidate.id)
            else
                redirect_to(edit_candidate_path(candidate.id))
            end            
        elsif session[:user_id]
            redirect_to new_answer_path;
        end
    end
    
    def about
    end
end