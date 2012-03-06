require 'spec_helper'

describe Category do
  describe "Associations/Validations" do
    it { should have_many :questions }
  end
end
