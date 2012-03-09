require 'spec_helper'

describe Subscriber do
  describe "Validations/Associations" do
    it { should validate_presence_of :email }
  end
end
