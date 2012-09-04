require 'spec_helper'

describe CandidatesController do

  describe "#get" do
    before do
      get :index
    end
    its(:status) { should be_== 200 }
  end


  describe "#check" do
    before do
      user = FactoryGirl.create(:candidate, email: 'test@tester.com', mobile_phone: '666666666', party: FactoryGirl.create(:party, symbol: 'PSDB'))
      post :check, format: "json", candidate: { email: 'test@test.com', mobile_phone: '5555555555', party: 'PT' }
    end
    it "should return an empty body when the candidate couldn't be found in the database" do
      expect(response.body).to eq("")
    end
  end
end
