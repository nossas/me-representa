class VotesController < ApplicationController
  inherit_resources
  belongs_to :question

  respond_to :json

  def create
    create! do |success, failure|
      success.json do
        session[:votes] << @question.id
        render :json => @question.as_json
      end
    end
  end
end
