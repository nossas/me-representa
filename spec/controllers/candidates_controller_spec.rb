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
      post :check, format: "json", candidate: { email: 'test@test.com', mobile_phone: '5555555555', party: 'PT' }
    end

    its(:body) { should be_== nil } 
  end
end
