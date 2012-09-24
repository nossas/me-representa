class LikesController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  actions :create, :update
  before_filter only: [:create, :update] { @like.user = current_user }

  def create
    create! { redirect_to :back and return }
  end

  def update
    update! { redirect_to :back and return }
  end
end
