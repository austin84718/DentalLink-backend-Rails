require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  describe 'permissions' do
    describe 'doctor permissions' do
      subject(:ability){ Ability.new(FactoryGirl.build(:doctor)) }

      it 'should grant permission to invite practice to doctor' do

        ability.should be_able_to(:create, PracticeInvitation.new)

      end

      it 'should be able to create referral' do
        ability.should be_able_to(:create, Referral.new)
      end

      it 'should be able to create patient' do
        ability.should be_able_to(:create, Patient.new)
      end
    end

    describe 'admin permissions' do
      subject(:ability){ Ability.new(FactoryGirl.build(:admin)) }
      it 'should grant permission to ' do
        ability.should be_able_to()
      end
    end
  end
end


