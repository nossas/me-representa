require 'spec_helper'

describe CandidatesController do

  describe "#get" do
    before do
      get :index
    end
    its(:status) { should be_== 200 }
  end


  describe "#check" do
    let(:user) { FactoryGirl.create(:candidate, email: 'test@tester.com', mobile_phone: '666666666', party: FactoryGirl.create(:party, symbol: 'PSDB')) }
    context "When the candidate is not yet registered on the database" do
      before do
        post :check, format: "json", candidate: { email: 'test@test.com', mobile_phone: '5555555555', party: 'PT' }
      end
      it "should return an empty body when the candidate couldn't be found in the database" do
        expect(response.body).to eq("null")
      end
    end

    context "When the candidate is registered but only email is valid on submission" do
      before do
        post :check, format: "json", candidate: { email: user.email, mobile_phone: 'wrong', party: user.party }
      end
      it "should return a hash describing that email is truthy" do
        expect(response.body).to eq("{\"email\":true,\"mobile_phone\":false}")
      end
    end
    context "When the candidate is registered but only mobile phone is valid on submission" do
      before do
        post :check, format: "json", candidate: { email: "ulaula@ula.com", mobile_phone: '666666666', party: user.party }
      end
      it "should return a hash describing that mobile phone is truthy" do
        expect(response.body).to eq("{\"email\":false,\"mobile_phone\":true}")
      end   
    end
  end
end
