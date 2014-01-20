require 'spec_helper'

describe Patient do
  subject { FactoryGirl.build(:patient) }
  describe 'fields validations' do
    it { should be_valid }

    describe 'is invalid without a first_name' do
      before { subject.first_name = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a last_name' do
      before { subject.last_name = nil }
      it { should_not be_valid }
    end

  end
end
