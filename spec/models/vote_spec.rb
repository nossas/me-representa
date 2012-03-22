require 'spec_helper'

describe Vote do
  before do
    Factory(:vote)
  end
  describe "Associations/Validations" do
    it { should belong_to :question }
    it { should belong_to :user }
    it { should validate_presence_of :question }
  end
end
