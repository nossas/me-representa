class AnswersController < ApplicationController
  layout 'merepresentalogged'
    
  load_and_authorize_resource
  inherit_resources

  optional_belongs_to :user, :polymorphic => true
  optional_belongs_to :candidate, :polymorphic => true
    
  before_filter :only => [:index, :new] { @questions = Question.chosen }
  
  before_filter :only => [:new] {  authorize!(:new, @answer || Answer) unless params[:candidate_id]} 
  before_filter :only => [:new, :create] { redirect_to root_path if params[:candidate_id] && params[:token] != Candidate.find(params[:candidate_id]).token }
  before_filter :only => [:new] { Candidate.assign_next_group Candidate.find(params[:candidate_id]) if params[:candidate_id] }

  def show
    show! { return render layout: false }
  end

  def create
    @answer = Answer.new
    @answer.question_id = params[:question_id]
    if @candidate
        @answer.responder = @candidate
    else
        @answer.responder = @user
    end
    @answer.short_answer = params[:short_answer]
    @answer.save
      
    render :json => @answer
    #create! { return render :json => @answer }
  end
  
  def update
    if params[:candidate_id]
      @answer.short_answer = params[:answer][:short_answer]
      @answer.responder = Candidate.find params[:candidate_id]
    else
      @answer.weight = params[:weight]
      @answer.responder = User.find params[:user_id]
    end
    if @answer.save
      render :json => @answer
    else
      render :status => 500
    end
  end

  def new
    if params[:candidate_id]
      @current_candidate = Candidate.find params[:candidate_id]
      if @current_candidate.finished_at
        redirect_to candidate_path @candidate
      else
        Question.where("chosen = true and role_type = 'truth'").each{|q|
          a = Answer.new
          a.question = q
          a.responder = @candidate
          a.short_answer = 'Não'
          a.weight = 0
          a.save
        }
        render(:file => "answers/new_for_candidate")
      end
    else
      Question.where("chosen = true and role_type = 'truth'").each do |q|
        if (not @current_user.answers) or (@current_user.answers.select{|a| a.question_id == q.id}.count == 0)
          a = Answer.new
          a.question = q
          a.responder = @current_user
          a.short_answer = 'Sim'
          a.weight = 0
          a.save
        end
      end
      @current_user = User.find @current_user.id
      new! { return render(:file => "answers/new_for_user") }
    end
  end
end