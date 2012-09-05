#coding: utf-8
class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
 
  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end


end
