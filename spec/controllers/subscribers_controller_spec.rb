require 'spec_helper'

describe SubscribersController do

  describe "GET #index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "POST #create" do
    it "should redirect to root path" do
      post :create, :subscriber => {:email => "my_email@test.com"}
      expect(response.status).to eq 302
    end
  end
end
