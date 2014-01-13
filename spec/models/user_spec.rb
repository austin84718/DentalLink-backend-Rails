require 'spec_helper'

describe User do
  describe 'fields validations' do

    it 'is invalid without a first_name' do
      User.create({first_name: nil}).should_not be_valid
    end
    it 'is invalid without a last_name' do
      User.create({last_name: nil}).should_not be_valid
    end
    it 'is invalid without a username' do
      User.create({username: nil}).should_not be_valid
    end
    it 'is invalid without a practice_id' do
      User.create({practice_id: nil}).should_not be_valid
    end
  end
end
