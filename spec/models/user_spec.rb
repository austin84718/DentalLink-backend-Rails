require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }
  describe 'fields validations' do
    it {should be_valid}

    describe 'is invalid without a first_name' do
      before { subject.first_name = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a last_name' do
      before { subject.last_name = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a practice_id' do
      before { subject.practice_id = nil }
      it { should_not be_valid }
    end
  end
end
