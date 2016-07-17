require 'spec_helper'

describe Question do
  describe "Validations/Associations" do
    it { should belong_to :category }
    it { should belong_to :user }
    it { should have_many :votes }
  end

  describe "Truth or Dare questions" do
    before do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category)
    end

    it "should fail when the role type is not Truth or Dare" do
      question = Question.create(:text => "Some text", :user => @user, :category => @category, :role_type => "wrong role")
      expect(question).not_to be_valid
      expect(question.errors[:role_type]).not_to be_empty
    end

    it "should succeed when the role type is Truth or Dare" do
      role = ['truth', 'dare']
      question =  Question.create(:text => "Some text", :user => @user, :category => @category, :role_type => role[rand(2)])
      expect(question).to be_valid
      expect(question.errors[:role_type]).to be_empty
    end
  end

  describe ".by_category_id" do
    before do
      @c = FactoryGirl.create(:category)
      @q = FactoryGirl.create(:question, :category => @c)
      FactoryGirl.create(:question)
    end
    subject{ Question.by_category_id @c.id }
    it{ should == [@q] }
  end

  describe ".by_type" do
    context "when we ask for truths" do
      before do
        @q = FactoryGirl.create(:question, :role_type => 'truth')
        FactoryGirl.create(:question, :role_type => 'dare')
      end
      subject{ Question.by_type 'truth' }
      it{ should == [@q] }
    end

    context "when we ask for dares" do
      before do
        @q = FactoryGirl.create(:question, :role_type => 'dare')
        FactoryGirl.create(:question, :role_type => 'truth')
      end
      subject{ Question.by_type 'dare' }
      it{ should == [@q] }
    end
  end

  describe "#truth?" do
    context "when it's a truth" do
      before { subject.role_type = "truth" }
      it{ should be_truth }
    end
    context "when it's not a truth" do
      before { subject.role_type = "dare" }
      it{ should_not be_truth }
    end
  end

  describe "#dare?" do
    context "when it's a dare" do
      before { subject.role_type = "dare" }
      it{ should be_dare }
    end
    context "when it's not a dare" do
      before { subject.role_type = "truth" }
      it{ should_not be_dare }
    end
  end
end
