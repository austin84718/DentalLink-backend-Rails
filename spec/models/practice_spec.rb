require 'spec_helper'

describe Practice do
  subject { FactoryGirl.build(:practice) }

  describe 'fields validations' do
    it {should be_valid}

    describe 'is invalid without an address_id' do
      before { subject.address = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a name' do
      before { subject.name = nil }
      it { should_not be_valid }
    end

    describe 'is invalid with blank name' do
      before { subject.name = ' ' }
      it { should_not be_valid }
    end

  end
end
