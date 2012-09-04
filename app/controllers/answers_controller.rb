class AnswersController < ApplicationController
  layout 'application_phase_two'
  inherit_resources
  belongs_to :candidate
  before_filter :only => [:new] { @questions = Question.chosen }
  before_filter :only => [:new, :create] { redirect_to root_path if params[:token] != Candidate.find(params[:candidate_id]).token }
  before_filter :only => [:new] { Candidate.assign_next_group Candidate.find(params[:candidate_id]) }

  def show
    show! { return render layout: false }
  end
end
