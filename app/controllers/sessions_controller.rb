class SessionsController < ApplicationController
  layout "merepresenta"
  skip_authorization_check

  def create
    # Now we can identify if login is from an user or from an candidate
    # type = "user" ou "candidate"
    type = request.env['omniauth.params']["type"]
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        @auth = Authorization.create_from_hash(auth, current_user)
        if type == "candidate"
            create_candidate @auth.user
            session[:candidate_id] = @auth.user.id
            session[:user_id] = @auth.user.id
            redirect_to(edit_candidate_path(@auth.user))
        else
            redirect_to(edit_user_path(@auth.user))
        end
    else
        self.current_user = @auth.user
        if type == "candidate"
            if not Candidate.exists? current_user.id
                create_candidate @auth.user
            end            
            if (Candidate.find current_user.id).finished_at
                redirect_to candidate_path(current_user.id)
            else
                redirect_to(edit_candidate_path(@auth.user.id))
            end
            session[:candidate_id] = @auth.user.id
            session[:user_id] = @auth.user.id
        else
            if (@auth.user.city)
                redirect_to(new_answer_path)
            else
                redirect_to(edit_user_path(@auth.user))
            end
        end
    end    
  end

  def destroy
    reset_session
    redirect_to root_path 
  end

  def new
  end
    
  private
    
    def create_candidate user
        c = Candidate.new
        c.id = @auth.user.id
        c.name = @auth.user.name
        c.save validate: false
    end
end
