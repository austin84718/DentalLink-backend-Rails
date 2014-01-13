require 'spec_helper'

describe Patient do
  describe 'fields validations' do

    it 'is invalid without a first_name' do
      Patient.create({first_name: nil}).should_not be_valid
    end

    it 'is invalid without a last_name' do
      Patient.create({last_name: nil}).should_not be_valid
    end

  end
end
