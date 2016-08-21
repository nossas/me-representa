class SessionsController < ApplicationController
  layout "application_phase_two"
  skip_authorization_check

  def create
    redirected = false
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
      p @auth
      redirect_to(edit_user_path(@auth.user))
      redirected = true
    end

    # Log the authorizing user in.
    self.current_user = @auth.user
    if(! redirected)
      redirect_to(session[:redirect_url] || root_path)
    end
  end

  def destroy
    reset_session
    redirect_to root_path 
  end

  def new
  end
end
