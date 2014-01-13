require 'spec_helper'

describe Address do
  describe 'fields validations' do

    it 'is invalid without a street_line_1' do
      Address.create({street_line_1: nil}).should_not be_valid
    end

    it 'is invalid without a city' do
      Address.create({city: nil}).should_not be_valid
    end

    it 'is invalid without a zip' do
      Address.create({zip: nil}).should_not be_valid
      end

    it 'is invalid without a zip' do
      Address.create({state: nil}).should_not be_valid
    end

  end
end
