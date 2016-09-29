# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :create_user_question_through_session
  before_filter { session[:votes] ||= [] }

  before_action :set_raven_context

  rescue_from CanCan::AccessDenied do |exception|
    session[:redirect_url] = request.url
    redirect_to "#{root_path}#login", :flash => {:login_alert => exception.message}
  end

  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def check_mrdash_token
    if not params[:token] or params[:token] != ENV["DASH_TOKEN"]
      render nothing: true, status: :unauthorized and return
    end
  end

  def create_user_question_through_session
    if session[:question] and current_user
      @question = Question.new session[:question]
      @question.user = current_user
      respond_to do |format|
        if @question.save
          session[:question] = nil
          format.html { redirect_to questions_path, :notice => "Sua pergunta foi publicada com sucesso! :-D" }
        else
          format.html { redirect_to questions_path, :alert => "Ops! Aparentemente alguma coisa deu errado! Cheque o formulário e tente novamente" }
        end
      end
    end
  end


  private
  def set_raven_context
    Raven.user_context(id: session[:user_id]) # or anything else in session
    Raven.extra_context(params: params.to_hash, url: request.url)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, request)
  end
end
