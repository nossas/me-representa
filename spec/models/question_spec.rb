require 'spec_helper'

describe Question do
  describe "Validations/Associations" do
    it { should belong_to :category }
    it { should belong_to :user }
    it { should validate_presence_of :text }
    it { should validate_presence_of :role_type }
    it { should validate_presence_of :category }
    it { should validate_presence_of :user }
  end
end
