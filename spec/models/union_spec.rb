# coding: utf-8
require 'spec_helper'

describe Union do
  describe ".match_for_user" do
    let(:question1) { FactoryGirl.create(:question) }
    let(:union1) { FactoryGirl.create(:union) }
    let(:union2) { FactoryGirl.create(:union) }
    let(:party1) { FactoryGirl.create(:party, :union => union1) }
    let(:party2) { FactoryGirl.create(:party, :union => union1) }
    let(:party3) { FactoryGirl.create(:party, :union => union2) }
    let(:party4) { FactoryGirl.create(:party, :union => union2) }
    let(:candidate1) { FactoryGirl.create(:candidate, :party => party1) }
    let(:candidate2) { FactoryGirl.create(:candidate, :party => party2) }
    let(:candidate3) { FactoryGirl.create(:candidate, :party => party3) }
    let(:candidate4) { FactoryGirl.create(:candidate, :party => party4) }
    let(:user) { FactoryGirl.create(:user) }
    subject { Union.match_for_user(user.id) }

    context "when there is a full matching with a union" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate3)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate4)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end
      it{ 
        should == [
          {"name" => union1.name, "id" => union1.id.to_s, "score" => "100", "type" => "Union"}, 
          {"name" => union2.name, "id" => union2.id.to_s, "score" => "0", "type" => "Union"}
        ] 
      }
    end

    context "when there is a half matching with a union" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate3)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate4)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end
      it{ 
        should == [
          {"name" => union1.name, "id" => union1.id.to_s, "score" => "50", "type" => "Union"}, 
          {"name" => union2.name, "id" => union2.id.to_s, "score" => "0", "type" => "Union"}
        ] 
      }
    end
  end
end
