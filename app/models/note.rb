class Note < ActiveRecord::Base
  belongs_to :referral
  belongs_to :user

  validates :message, presence: true
end
