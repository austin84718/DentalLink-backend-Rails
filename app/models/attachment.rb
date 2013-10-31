class Attachment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :referral
end
