require 'spec_helper'

describe Authorization do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "Validations/Associations" do
    it { should belong_to :user }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
  end


  describe "#find_from_hash" do
    it "Should find the provider and UID when it's already in database" do

      mr = MEURIO_HASH
      authorization = FactoryGirl.create(:authorization, :provider => mr['provider'], :uid => mr['uid'], :user => @user)
      Authorization.find_from_hash(mr).should_not be_nil
    end

    it "Should return nil if the provider/uid isn't in the DB" do
      Authorization.destroy_all
      Authorization.find_from_hash(MEURIO_HASH).should == nil
    end
  end


  describe "#create_from_hash" do
    before do
      @mr = MEURIO_HASH
    end

    context "When an user exists" do
      subject { Authorization.create_from_hash(@mr, @user) }

      it "should return an existent" do
        expect(subject['uid']).to eq @mr['uid']
        expect(subject['provider']).to eq @mr['provider']
        expect(subject['user']).to eq @user
      end
    end

    context "When the user doesn't exists" do
      subject { Authorization.create_from_hash(@mr) }

      it "should create" do
        expect(subject['uid']).to eq @mr['uid']
        expect(subject['provider']).to eq @mr['provider']
        expect(subject['user']).not_to be nil
      end
    end
  end
end
