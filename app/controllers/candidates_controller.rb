# coding: utf-8
class CandidatesController < ApplicationController
  layout "merepresentalogged"
  
  inherit_resources
  respond_to :csv

  load_and_authorize_resource
  skip_authorize_resource :only => [:check, :home, :create  ]

  optional_belongs_to :party
  optional_belongs_to :union

  has_scope :by_age do |controller, scope, value|
    case value.to_i
    when 1
      scope.by_age(18,25)
    when 2
      scope.by_age(26,35)
    when 3
      scope.by_age(36,45)
    when 4
      scope.by_age(45,100)
    end
  end

  has_scope :by_scholarity,  type: :array do |controller, scope, value|
    scope.by_scholarity(value.delete_if(&:blank?))
  end
  has_scope :by_reelection,  type: :array do |controller, scope, value|
    scope.by_reelection(value.delete_if(&:blank?))
  end
  has_scope :by_gender, type: :array do |controller, scope, value|
    scope.by_gender(value.delete_if(&:blank?))
  end

  before_filter { @user = User.find(params[:user_id]) if params[:user_id] }
  before_filter only: [:home] { @truths = Question.truths.chosen; @dares = Question.dares.chosen }
  before_filter only: [:edit] { @current_user = User.find session[:user_id] }

  before_filter only: [:create] do
    @candidate.id = params['f_code']
  end
  before_filter only: [:index] do
    if params[:user_id] and params[:party_id]
      @candidates = apply_scopes(Candidate).match_for_user(params[:user_id], { party_id: @party.id })
    elsif params[:user_id] and params[:union_id]
      @candidates = apply_scopes(Candidate).match_for_user(params[:user_id], { union_id: @union.id })
    elsif params[:party_id] and !params[:user_id]
      @candidates = @party.candidates
    elsif params[:union_id] and !params[:user_id]
      @candidates = @union.candidates
    end
  end

  before_filter :only => [:index] { render partial: 'candidates/list', locals: { candidates: @candidates } if request.xhr? }
  before_filter :only => [:check] { render json: nil if params[:candidate][:email].blank? and params[:candidate][:mobile_phone].blank? }


  def home;end

  def create
    create! do |success, failure|
      success.html { redirect_to new_candidate_answer_url(@candidate, :token => @candidate.token) }
      failure.html { 
        envia_erros(@candidate)
      }
    end
  end
    
  def profile
      
  end

  def show
    @candidate = Candidate.find params[:id]
    render layout: "merepresentaunlogged" if not session[:user_id]
  end

  def update
    update! do |success, failure|
      success.html { redirect_to new_candidate_answer_url(@candidate, :token => @candidate.token) }
      failure.html { 
        envia_erros(@candidate)
      }
    end
  end

  def confirm
    @current_candidate = Candidate.find session[:candidate_id]
  end

  def finish
    @candidate = Candidate.find(session[:candidate_id])
    @candidate.update_attributes :finished_at => Time.now
    CandidateMailer.finished(@candidate).deliver
  end
  
  def check
    candidate = params[:candidate]
    @candidate = Candidate.find_by_email(candidate[:email]) || Candidate.find_by_mobile_phone(candidate[:mobile_phone])
    result = { 
      email: (@candidate.present? ? candidate[:email] == @candidate.email : false), 
      mobile_phone: (@candidate.present? ? candidate[:mobile_phone] == @candidate.mobile_phone : false) 
    }
    respond_to do |format|
      if @candidate.nil?
        format.json { render json: nil }
      else 
        format.json {
          render json: result 
        }

        CandidateMailer.resend_unique_url(@candidate).deliver             if result[:email]         == true
        CandidateMailer.notify_meurio(@candidate).deliver                 if result[:mobile_phone]  == true and result[:email] == false
        
        if result[:email] == true and result[:mobile_phone] == true
          CandidateMailer.resend_unique_url(@candidate).deliver
          CandidateMailer.notify_meurio(@candidate).deliver
        end
      end
    end
  end

  private
    def envia_erros(modelo)
        msgs = {}
        modelo.errors.keys.each {|k| msgs[k] = modelo.errors[k].join("; ") }
        flash[:erros] = msgs
        flash[:candidate] = modelo
        redirect_to :back # edit_user_path(modelo.id)       
    end
end
