require 'spec_helper'

describe UsersController do
  describe "#index" do
    context "When not an admin user" do
      it "should be unauthorized" do
        get :index, format: :csv
        expect(response.status).to eq 401
      end
    end

    context "When an admin user" do
       it "should render successfully" do
        user = FactoryGirl.create(:user, admin: true)
        controller.stub!(:current_user).and_return(user)

        get :index, format: :csv
        expect(response.status).to eq 200
      end
    end
  end
end
