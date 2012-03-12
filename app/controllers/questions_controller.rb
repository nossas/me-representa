class QuestionsController < ApplicationController
  inherit_resources
  load_and_authorize_resource

  def index
    @question = Question.new
    @truths ||= Question.truth
    @dares ||= Question.dare
  end

  def create
    @question = Question.new params[:question]
    @question.user = current_user
    create!(:notice => "Criado com sucesso", :alert => "Ops! Erros ocorreram!"){ questions_path }
  end


  def current_ability
    @current_ability ||= Ability.new(current_user)
  end



end
