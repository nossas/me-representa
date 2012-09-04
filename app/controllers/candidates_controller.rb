class CandidatesController < ApplicationController
  inherit_resources
  layout "application_phase_two"
  before_filter :only => [:index] { @truths = Question.truths.chosen}
  before_filter :only => [:index] { @dares = Question.dares.chosen}
  before_filter :only => [:update]{ resource.update_attribute(:finished_at, Time.now) if params[:candidate][:finished_at] }
  before_filter :only => [:check] { return unless params[:candidate][:email].present? and params[:candidate][:mobile_phone].present? }

  def check
    candidate = params[:candidate]
    @candidate = Candidate.find_by_email(candidate[:email]) || Candidate.find_by_mobile_phone(candidate[:mobile_phone])
    respond_to do |format|
      unless @candidate.present?
        format.json { render json: "" }
      else
        format.json { render json: {} }
      end      
    end
  end
end
