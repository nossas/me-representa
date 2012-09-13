class AnswersController < ApplicationController
  layout 'application_phase_two'
  inherit_resources
  belongs_to :candidate, :polymorphic => true
  belongs_to :user, :polymorphic => true
  before_filter :only => [:new] { @questions = Question.chosen }
  before_filter :only => [:new, :create] { redirect_to root_path if params[:candidate_id] && params[:token] != Candidate.find(params[:candidate_id]).token }
  before_filter :only => [:new] { Candidate.assign_next_group Candidate.find(params[:candidate_id]) if params[:candidate_id] }

  def show
    show! { return render layout: false }
  end

  def create
    create! { return render :file => "answers/show", layout: false }
  end
  
  def update
    update! { return render :file => "answers/show", layout: false }
  end

  def new
    new! { return params[:candidate_id] ? render(:file => "answers/new_for_candidate") : render(:file => "answers/new_for_user") }
  end
end
