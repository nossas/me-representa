require 'spec_helper'

describe QuestionsController do
  subject{ response }

  describe "GET 'more'" do
    before{ get :more }
    it{ should be_success }
  end

  describe "GET 'index'" do
    before{ get :index }
    it{ should be_success }
  end

end
