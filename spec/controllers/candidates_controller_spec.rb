require 'spec_helper'

describe CandidatesController do

  describe "#get" do
    before do
      get :index
    end
    its(:status) { should be_== 200 }
  end
end
