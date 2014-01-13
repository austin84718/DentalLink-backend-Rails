require 'spec_helper'

describe Practice do
  describe 'fields validations' do

    it 'is invalid without an address_id' do
      Practice.create({address_id: nil, name: 'name'}).should_not be_valid
    end

    it 'is invalid without a name' do
      Practice.create({name: nil, address_id: 1}).should_not be_valid
    end

    it 'is invalid without a name' do
      Practice.create({name: '', address_id: 1}).should_not be_valid
    end

  end
end
