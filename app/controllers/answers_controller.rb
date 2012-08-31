class AnswersController < ApplicationController
  
  layout 'application_phase_two'
  inherit_resources
  belongs_to :candidate
  before_filter :only => [:new] { @questions = Question.chosen }
  before_filter :only => [:new, :create] do 
    candidate = Candidate.find(params[:candidate_id])
    if params[:token] != candidate.token
      redirect_to root_path 
    end
  end


  def show
    show! { return render layout: false }
  end
end
