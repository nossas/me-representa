require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "POST 'new'" do
    before do
      post :new
    end
    it "returns http success" do
      response.should be_success
    end
  end

end
