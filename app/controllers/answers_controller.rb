class AnswersController < ApplicationController
  inherit_resources
  belongs_to :candidate
  before_filter :only => [:new] { @questions = Question.chosen }
end
