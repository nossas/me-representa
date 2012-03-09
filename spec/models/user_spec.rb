require 'spec_helper'

describe User do
  describe "Validations & Associations" do
    it { should have_many :questions }
    it { should validate_presence_of :email }
  end
end
