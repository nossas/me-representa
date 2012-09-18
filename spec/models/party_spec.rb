# coding: utf-8
require 'spec_helper'

describe Party do
  describe ".match_for_user" do
    let(:question1) { FactoryGirl.create(:question) }
    let(:party1) { FactoryGirl.create(:party) }
    let(:party2) { FactoryGirl.create(:party) }
    let(:candidate1) { FactoryGirl.create(:candidate, :party => party1) }
    let(:candidate2) { FactoryGirl.create(:candidate, :party => party1) }
    let(:candidate3) { FactoryGirl.create(:candidate, :party => party2) }
    let(:candidate4) { FactoryGirl.create(:candidate, :party => party2) }
    let(:user) { FactoryGirl.create(:user) }
    subject { Party.match_for_user(user.id) }

    context "when there is a full matching with a party" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate3)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate4)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end
      it{ 
        should == [
          {"name" => party1.symbol, "id" => party1.id.to_s, "score" => "100", "type" => "Party"}, 
          {"name" => party2.symbol, "id" => party2.id.to_s, "score" => "0", "type" => "Party"}
        ] 
      }
    end

    context "when there is a half matching with a party" do
      before do
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Sim", :responder => candidate1)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate2)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate3)
        FactoryGirl.create(:candidate_answer, :question => question1, :short_answer => "Não", :responder => candidate4)
        FactoryGirl.create(:user_answer, :question => question1, :short_answer => "Sim", :responder => user)
      end
      it{ 
        should == [
          {"name" => party1.symbol, "id" => party1.id.to_s, "score" => "50", "type" => "Party"}, 
          {"name" => party2.symbol, "id" => party2.id.to_s, "score" => "0", "type" => "Party"}
        ]
      }
    end
  end
end
