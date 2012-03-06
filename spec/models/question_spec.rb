require 'spec_helper'

describe Question do
  describe "Validations/Associations" do
    it { should belong_to :category }
    it { should belong_to :user }
  end
end
