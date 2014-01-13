class Attachment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :referral

  validates :filename, presence: true
end
