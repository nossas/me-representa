require 'spec_helper'

describe QuestionsController do
  subject{ response }

  let(:question){ Factory(:question) }

  describe "GET 'show'" do
    before{ get :show, :id => question.id }
    it{ should be_success }
  end

  describe "GET 'index'" do
    before{ get :index }
    it{ should be_success }
  end

end
