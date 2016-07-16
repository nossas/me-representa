require 'spec_helper'

describe AnswersController do
  describe "#create" do
    before do
      candidate = FactoryGirl.create(:candidate)
      question  = mock_model(Question, id: 2)
    end

    it "should show an answer" do
      post :create, candidate_id: candidate.id, question_id: question.id, token: 123, format: :js

      expect(response.status).to eq 302
    end
  end
end
