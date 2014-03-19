class Note < ActiveRecord::Base
  belongs_to :referral

  validates :message, presence: true
end
