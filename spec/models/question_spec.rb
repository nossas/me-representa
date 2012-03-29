require 'spec_helper'

describe Question do
  describe "Validations/Associations" do
    it { should belong_to :category }
    it { should belong_to :user }
    it { should have_many :votes }
  end

  describe "Truth or Dare questions" do
    before do
      @user = Factory(:user)
      @category = Factory(:category)
    end

    it "should fail when the role type is not Truth or Dare" do
      question = Question.create(:text => "Some text", :user => @user, :category => @category, :role_type => "wrong role")
      question.should have(1).error_on(:role_type)
      question.should_not be_valid
    end

    it "should succeed when the role type is Truth or Dare" do
      role = ['truth', 'dare']
      question =  Question.create(:text => "Some text", :user => @user, :category => @category, :role_type => role[rand(2)])
      question.should have(0).error_on(:role_type)
      question.should be_valid
    end
  end

  describe ".by_category_id" do
    before do
      @c = Factory(:category)
      @q = Factory(:question, :category => @c)
      Factory(:question)
    end
    subject{ Question.by_category_id @c.id }
    it{ should == [@q] }
  end

  describe ".by_type" do
    context "when we ask for truths" do
      before do
        @q = Factory(:question, :role_type => 'truth')
        Factory(:question, :role_type => 'dare')
      end
      subject{ Question.by_type 'truth' }
      it{ should == [@q] }
    end

    context "when we ask for dares" do
      before do
        @q = Factory(:question, :role_type => 'dare')
        Factory(:question, :role_type => 'truth')
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
