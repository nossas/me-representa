class CandidatesController < ApplicationController
  respond_to :html
  respond_to :json, only: [:check]
  inherit_resources
  custom_actions resource: :check
  layout "application_phase_two"
  before_filter :only => [:index] {@truths = Question.truths.chosen}
  before_filter :only => [:index] {@dares = Question.dares.chosen}
  before_filter :only => [:update] { resource.update_attribute(:finished_at, Time.now) if params[:candidate][:finished_at] }

  def check
    candidate = params[:candidate]
    return unless candidate[:email] and candidate[:mobile_phone]
    @candidate = Candidate.find_by_email(candidate[:email]) || Candidate.find_by_mobile_phone(candidate[:mobile_phone])
    check! do |format|
      if @candidate.blank?
        format.json { render json: nil }
      else
        format.json { render nil }
      end      
    end
  end
end
