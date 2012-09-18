# coding: utf-8
require 'spec_helper'

describe Candidate do
  describe ".match_for_user" do
    let(:union1) { FactoryGirl.create(:union) }
    let(:party1) { FactoryGirl.create(:party, :union => union1) }
    let(:question1) { FactoryGirl.create(:question) }
    let(:question2) { FactoryGirl.create(:question) }
    let(:candidate1) { FactoryGirl.create(:candidate, :party => party1) }
    let(:candidate2) { FactoryGirl.create(:candidate) }
    let(:user) { FactoryGirl.create(:user) }
    subject { Candidate.match_for_user(user.id) }

    context "when I have a full match" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end

      it{ should == [{"name" => candidate1.name, "score" => "100"}, {"name" => candidate2.name, "score" => "0"}] }
    
      context "when I look for candidates in a specific party" do
        subject { Candidate.match_for_user(user.id, :party_id => party1.id) }
        it{ should == [{"name" => candidate1.name, "score" => "100"}] }
      end
      
      context "when I look for candidates in a specific union" do
        subject { Candidate.match_for_user(user.id, :union_id => union1.id) }
        it{ should == [{"name" => candidate1.name, "score" => "100"}] }
      end
    end
    
#    context "when I have different weights for questions" do
#      before do
#        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
#        FactoryGirl.create(:candidate_answer, :question => question2, :short_answer => "Sim", :responder => candidate1)
#        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
#        FactoryGirl.create(:candidate_answer, :question => question2, :short_answer => "Não", :responder => candidate2)
#        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user, :weight => 2)
#        FactoryGirl.create(:user_answer, :question => question2, :short_answer => "Não", :responder => user, :weight => 1)
#      end
#      
#      it{ should == [{"name" => candidate1.name, "score" => "67"}, {"name" => candidate2.name, "score" => "33"}] }
#
#    end
    
  end
end

