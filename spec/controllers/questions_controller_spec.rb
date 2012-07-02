require 'spec_helper'

describe QuestionsController do
  subject{ response }

  let(:question){ FactoryGirl.create(:question) }

  describe "GET 'show'" do
    before{ get :show, :id => question.id }
    it{ should be_success }
  end

  describe "GET 'index'" do
    context "When its a XHR request" do
      before do
        xhr :get, :index
      end
      it { should be_success }
    end

    context "When an invalid token is provided and it is not XHR" do
      before do
        get :index, token: "TOKEN", format: "json"
      end
      its(:status) { should == 401 }
    end

    context "When a valid token is provided and it is not XHR" do
      before do 
        ENV["DASH_TOKEN"] = "MYTOKEN"
        get :index, token: "MYTOKEN", format: "json"
      end
      its(:status) { should == 200 }
    end
  end

end
