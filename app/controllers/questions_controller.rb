class QuestionsController < ApplicationController
  inherit_resources

  def index
    @question = Question.new
    @truths ||= Question.truth
    @dares ||= Question.dare
  end


end
