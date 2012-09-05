require 'spec_helper'

describe UsersController do
  describe "#index" do
#    context "When not an admin user" do
      #before do
        #get :index, format: :csv
      #end
      #its(:status) { should_not be_== 200 }
    #end

    context "When an admin user" do
      before do 
        user = FactoryGirl.create(:user, admin: true)  
        controller.stub!(:current_user).and_return(user)
        get :index, format: :csv
      end
      its(:status) { should be_== 200 }
    end
  end
end
