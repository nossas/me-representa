class CandidatesController < ApplicationController
  layout "application_phase_two"
  before_filter :only => [:index] {@questions = Question.chosen}

  def index
  end
end
