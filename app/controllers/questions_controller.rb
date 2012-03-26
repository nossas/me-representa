# coding: utf-8
class QuestionsController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @truths ||= Question.truth
    @dares ||= Question.dare
    if request.xhr?
      render (params[:type_role] == "truth" ? @truths : @dares) and return true
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
end
