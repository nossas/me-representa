class CandidatesController < ApplicationController
  inherit_resources
  actions :update
  layout "application_phase_two"
  before_filter :only => [:index] {@truths = Question.truths.chosen}
  before_filter :only => [:index] {@dares = Question.dares.chosen}

  before_filter :only => [:update] { resource.update_attribute(:finished_at, Time.now) if params[:candidate][:finished_at] }

  def index;end
end
