# coding: utf-8
require 'spec_helper'

describe Candidate do
  describe "Validations & Associations" do
    it { should have_many :answers }
    it { should belong_to :party }
  end


  describe ".match_for_user" do
    let(:union1) { FactoryGirl.create(:union) }
    let(:party1) { FactoryGirl.create(:party, :union => union1) }
    let(:question1) { FactoryGirl.create(:question) }
    let(:question2) { FactoryGirl.create(:question) }
    let(:candidate1) { FactoryGirl.create(:candidate, :party => party1) }
    let(:candidate2) { FactoryGirl.create(:candidate) }
    let(:candidate3) { FactoryGirl.create(:candidate) }
    let(:candidate4) { FactoryGirl.create(:candidate, party: party1) }
    let(:user) { FactoryGirl.create(:user) }
    subject { Candidate.match_for_user(user.id) }

    context "when I have a full match" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end

     it{ should == [
        {"id" => candidate1.id.to_s, "symbol" => candidate1.party.symbol, "name" => candidate1.name, "nickname" => candidate1.nickname, "score" => "100"},
        {"id" => candidate2.id.to_s, "symbol" => candidate2.party.symbol, "name" => candidate2.name, "nickname" => candidate2.nickname, "score" => "0"}
      ]}
    
      context "when I look for candidates in a specific party" do
        subject { Candidate.match_for_user(user.id, :party_id => party1.id) }
        it{ should == [{"id" => candidate1.id.to_s, "symbol" => candidate1.party.symbol, "name" => candidate1.name, "nickname" => candidate1.nickname, "score" => "100"}] }
      end

      context "when I look for candidates in a specific union" do
        subject { Candidate.match_for_user(user.id, :union_id => union1.id) }
        it{ should == [{"id" => candidate1.id.to_s, "symbol" => candidate1.party.symbol, "name" => candidate1.name, "nickname" => candidate1.nickname, "score" => "100"}] }
      end
    end

    context "when I have different weights for questions" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question2, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question2, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate3)
        FactoryGirl.create(:candidate_answer, :question => question2, :short_answer => "Sim", :responder => candidate3)

        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user, :weight => 2)
        FactoryGirl.create(:user_answer, :question => question2, :short_answer => "Não", :responder => user, :weight => 1)
      end
      it{ should == [
        {"id" => candidate1.id.to_s, "symbol" => candidate1.party.symbol, "name" => candidate1.name, "nickname" => candidate1.nickname, "score" => "67"}, 
        {"id" => candidate2.id.to_s, "symbol" => candidate2.party.symbol, "name" => candidate2.name, "nickname" => candidate2.nickname, "score" => "33"},
        {"id" => candidate3.id.to_s, "symbol" => candidate3.party.symbol, "name" => candidate3.name, "nickname" => candidate3.nickname, "score" => "0"}
         ]}
    end 

    context "When the candidate answered one question of two that the user answered" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate4)

        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user, :weight => 1)
        FactoryGirl.create(:user_answer, :question => question2, :short_answer => "Não", :responder => user, :weight => 2)
      end

      it "should return 33% (1/3) when the user answered 1 question against 2 the user answered with weight 1 and 2. " do
	      pending
#        subject.should == [
#          {"id" => candidate4.id.to_s, "symbol" => candidate4.party.symbol, "name" => candidate4.name, "nickname" => candidate4.nickname, "score" => "33"}
#        ]  
      end
    end
  end

  describe "#gang" do
    let(:union) { FactoryGirl.create :union }
    let(:party1) { FactoryGirl.create :party, :union => union }
    let(:party2) { FactoryGirl.create :party, :union => union }
    subject { FactoryGirl.create :candidate, :party => party1 }

    context "when the candidate have no brother" do
      it "should be empty" do
        expect(subject.gang).to be_empty
      end
    end

    context "when the candidate have a brother in his party" do
      let(:the_brother) { FactoryGirl.create(:candidate, :party => party1) }

      it "should include it" do
        expect(subject.gang).to include the_brother
      end
    end

    context "when the candidate have a brother in his union" do
      let(:the_brother) { FactoryGirl.create(:candidate, :party => party2) }

      it "should include it" do
        expect(subject.gang).to include the_brother
      end
    end
  end

end
