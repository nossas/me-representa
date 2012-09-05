# coding: utf-8
class CandidatesController < ApplicationController
  inherit_resources
  respond_to :csv
  layout "application_phase_two"
  load_and_authorize_resource
  before_filter :only => [:index] {@truths = Question.truths.chosen}
  before_filter :only => [:index] {@dares = Question.dares.chosen}
  before_filter :only => [:check] { render json: nil if params[:candidate][:email] == "" and params[:candidate][:mobile_phone] == "" }

  def finish
    @candidate = Candidate.find(params[:candidate_id])
    @candidate.update_attributes :finished_at => Time.now
    CandidateMailer.finished(@candidate).deliver
    redirect_to root_path, :notice => "#{@candidate.name}, seu questionário foi enviado com sucesso, obrigado pela sua participação!"
  end
  
  def check
    candidate = params[:candidate]
    @candidate = Candidate.find_by_email(candidate[:email]) || Candidate.find_by_mobile_phone(candidate[:mobile_phone])
    result = { email: (@candidate.email == candidate[:email]), mobile_phone: (@candidate.mobile_phone == candidate[:mobile_phone]) }
    respond_to do |format|
      if @candidate.nil?
        format.json { render json: nil }
      else 
        format.json {
          render json: result 
        }

        CandidateMailer.resend_unique_url(@candidate).deliver if result[:email] == true
      end
    end
  end

end
