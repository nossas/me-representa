require 'spec_helper'

describe AnswersController do
  describe "#create" do
    before do
      candidate = FactoryGirl.create(:candidate) 
      question  = mock_model(Question, id: 2)
      post :create, candidate_id: candidate.id, question_id: question.id, token: 123, format: :js
    end
    its(:status) { should == 302 }
  end
end
