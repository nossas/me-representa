#coding: utf-8
class SubscribersController < ApplicationController

  inherit_resources
  def index
    @user = Subscriber.new
  end

  def create
    create!{ return redirect_to root_path, :notice => "Obrigado pelo interesse, lhe manteremos informado!"}
  end

end
