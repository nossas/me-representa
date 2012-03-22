# coding: utf-8
class QuestionsController < ApplicationController
  inherit_resources
  load_and_authorize_resource

  respond_to :html, :json

  def index
    @question = Question.new
    @truths ||= Question.truth
    @dares ||= Question.dare
  end

  def create
    if request.xhr?
      render :partial => "share"
    else
      if current_user
        @question = Question.new params[:question]
        @question.user = current_user
        create! do |success, failure|
          success.html { redirect_to :back, :notice => "Sua pergunta foi publicada com sucesso! :-D" }
          failure.html { redirect_to :back, :alert => "Ops! Aparentemente alguma coisa deu errado! Cheque o formulário e tente novamente" }
        end
      else
        session[:question] = params[:question]
        redirect_to '/auth/facebook/' and return if params[:provider][:facebook]
        redirect_to '/auth/meurio/' and return if params[:provider][:meurio]
      end
    end
  end


  def current_ability
    @current_ability ||= Ability.new(current_user)
  end



end
