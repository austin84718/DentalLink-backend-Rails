require 'spec_helper'

describe Attachment do
  subject { FactoryGirl.build(:attachment) }
  describe 'fields validations' do

    it { should be_valid }

    describe 'is invalid without a filename' do
      before { subject.filename = nil }
      it { should_not be_valid }
    end

  end
end
