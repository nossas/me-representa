class VotesController < ApplicationController
  inherit_resources
  belongs_to :question

  def create
    create! do |success, failure|
      success.html do
        session[:votes] << @question.id
        render :partial => "questions/buttons", :locals => {:question => @question}
      end
    end
  end
end
