require 'spec_helper'

describe SubscribersController do

  describe "GET #index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "POST #create" do
    before do
      post :create, :subscriber => {:email => "my_email@test.com"}
    end
    its(:status) { should == 302 }
  end

end
