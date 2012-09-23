require 'spec_helper'

describe Like do
  describe "Validations & Associations" do
    it { should belong_to :user }
    it { should belong_to :candidate }
  end
end
