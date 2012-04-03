class VotesController < ApplicationController
  inherit_resources
  respond_to :json
  belongs_to :question

  def create
    create! do |success, failure|
      success.json do
        session[:votes] << @question.id
        render :json => @question.as_json
      end
    end
  end
end
