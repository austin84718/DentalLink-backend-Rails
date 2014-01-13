require 'spec_helper'

describe Attachment do
  describe 'fields validations' do

    it 'is invalid without a filename' do
      Attachment.create({filename: nil}).should_not be_valid
    end
  end
end
