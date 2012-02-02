#coding: utf-8
class UsersController < ApplicationController

  inherit_resources
  def index
    @user = User.new
  end

  def new
    create!{ return redirect_to root_path, :notice => "Obrigado pelo interesse, lhe manteremos informado!"}
  end

end
