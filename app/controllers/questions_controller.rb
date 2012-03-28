# coding: utf-8
class QuestionsController < ApplicationController
  MAX_QUESTIONS = 5
  inherit_resources
  load_and_authorize_resource
  respond_to :html, :json

  has_scope :by_type
  has_scope :recent_first, :type => :boolean

  def index
    if request.xhr?
      render collection, :layout => false and return true
    end
  end

  def create
    @question = Question.new params[:question]
    @question.user = current_user
    create! do |success, failure|
      success.html { render :partial => "share" }
      failure.html { render :partial => "form", :locals => {:question => @question} }
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  protected
  def collection
    @questions ||= end_of_association_chain.limit(MAX_QUESTIONS)
  end
end
