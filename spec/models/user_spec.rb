require 'spec_helper'

describe User do
  describe "Validations & Associations" do
    it { should have_many :questions }
    it { should have_one :like }
    it { should validate_presence_of :email }
  end

  describe "admin?" do
    context "The user is an admin" do
      let(:user) { FactoryGirl.create(:user, admin: true) }
      subject { user.admin? }

      it { should == true }
    end
    context "The user is NOT an admin" do
      let(:user) { FactoryGirl.create(:user) }
      subject { user.admin? }
      it { should == false }
    end
  end
end
