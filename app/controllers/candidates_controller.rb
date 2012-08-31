class CandidatesController < ApplicationController
  inherit_resources
  actions :update
  layout "application_phase_two"
  before_filter :only => [:index] {@truths = Question.truths.chosen}
  before_filter :only => [:index] {@dares = Question.dares.chosen}

  def index
  end
end
