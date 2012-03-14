# coding: utf-8
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
    create!(
      :notice => "Sua pergunta foi publicada com sucesso! :-)",
      :alert => "Ops! Aparentemente alguma coisa deu errado! Cheque o formulário e tente novamente."
    ){ questions_path }
  end


  def current_ability
    @current_ability ||= Ability.new(current_user)
  end



end
