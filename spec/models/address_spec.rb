require 'spec_helper'

describe Address do
  subject { FactoryGirl.build(:address) }

  describe 'fields validations' do

    it { should be_valid }

    describe 'is invalid without a street_line_1' do
      before { subject.street_line_1 = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a city' do
      before { subject.city = nil }
      it {should_not be_valid}
    end

    describe 'is invalid without a zip' do
      before { subject.zip = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without a state' do
      before { subject.state = nil }
      it { should_not be_valid}
    end

  end
end
