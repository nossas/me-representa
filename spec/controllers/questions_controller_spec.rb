require 'spec_helper'

RSpec.describe QuestionsController, type: :controller do
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
      it "should unauthorize access" do
        get :index, token: "TOKEN", format: "json"
        expect(response.status).to eq 401
      end
    end

    context "When a valid token is provided and it is not XHR" do
      it "should render successfully" do
        ENV["DASH_TOKEN"] = "MYTOKEN"
        get :index, token: "MYTOKEN", format: "json"
        expect(response.status).to eq 200
      end
    end
  end

end
