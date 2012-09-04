# coding: utf-8
class CandidatesController < ApplicationController
  inherit_resources
  respond_to :csv
  layout "application_phase_two"
  load_and_authorize_resource
  before_filter :only => [:index] {@truths = Question.truths.chosen}
  before_filter :only => [:index] {@dares = Question.dares.chosen}

  def finish
    @candidate = Candidate.find(params[:candidate_id])
    @candidate.update_attributes :finished_at => Time.now
    CandidateMailer.finished(@candidate).deliver
    redirect_to root_path, :notice => "#{@candidate.name}, seu questionário foi enviado com sucesso, obrigado pela sua participação!"
  end
end
