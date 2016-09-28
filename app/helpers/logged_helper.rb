module LoggedHelper
	def load_logged
        if (session[:user_id] or session[:candidate_id])
            @current_user = User.find session[:user_id] if session[:user_id]
            @current_candidate = Candidate.find session[:candidate_id] if session[:candidate_id]
        end
	end
end
