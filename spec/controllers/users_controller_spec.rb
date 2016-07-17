require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "When not an admin user" do
      it "should redirect" do
        get :index, format: :csv
        expect(response.status).to eq 302
      end
    end

    context "When an admin user" do
       it "should render successfully" do
        user = FactoryGirl.create(:user, admin: true)
        allow(controller).to receive(:current_user).and_return(user)

        get :index, format: :csv
        expect(response.status).to eq 200
      end
    end
  end
end
