# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :create_user_question_through_session
  before_filter { session[:votes] ||= [] }

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

end
