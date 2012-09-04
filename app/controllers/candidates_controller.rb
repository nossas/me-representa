class CandidatesController < ApplicationController
  inherit_resources
  layout "application_phase_two"
  before_filter :only => [:index] { @truths = Question.truths.chosen}
  before_filter :only => [:index] { @dares = Question.dares.chosen}
  before_filter :only => [:update]{ resource.update_attribute(:finished_at, Time.now) if params[:candidate][:finished_at] }
  before_filter :only => [:check] { render json: nil if params[:candidate][:email] == "" and params[:candidate][:mobile_phone] == "" }

  def check
    candidate = params[:candidate]
    @candidate = Candidate.find_by_email(candidate[:email]) || Candidate.find_by_mobile_phone(candidate[:mobile_phone])
    respond_to do |format|
      if @candidate.nil?
        format.json { render json: nil }
      else 
        format.json {
          render json: { email: (@candidate.email == candidate[:email]), mobile_phone: (@candidate.mobile_phone == candidate[:mobile_phone]) } 
        }
      end
    end
  end
end
