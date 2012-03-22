class VotesController < ApplicationController
  inherit_resources
  respond_to :json
  belongs_to :question
end
