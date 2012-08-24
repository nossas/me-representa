require 'spec_helper'

describe UsersController do
  describe "#index" do
    before do
      get :index, format: :csv
    end

    its(:status) { should be_== 200 }
  end
end
