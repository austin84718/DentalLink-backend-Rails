require 'spec_helper'

describe Referral do
  subject { FactoryGirl.build(:referral) }
  describe 'fields validations' do
    it { should be_valid }

    describe 'is invalid without an orig_practice_id' do
      before { subject.orig_practice_id = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without an dest_practice_id' do
      before { subject.dest_practice_id = nil }
      it { should_not be_valid }
    end

    describe 'is invalid without an patient_id' do
      before { subject.patient_id = nil }
      it { should_not be_valid }
    end
  end
end