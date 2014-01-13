require 'spec_helper'

describe Referral do
  describe 'fields validations' do

    it 'is invalid without an orig_practice_id' do
      Referral.create({orig_practice_id: nil}).should_not be_valid
    end

    it 'is invalid without an dest_practice_id' do
      Referral.create({dest_practice_id: nil}).should_not be_valid
    end

    it 'is invalid without an patient_id' do
      Referral.create({patient_id: nil}).should_not be_valid
    end

  end
end