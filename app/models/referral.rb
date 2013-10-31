class Referral < ActiveRecord::Base
  belongs_to :orig_practice
  belongs_to :dest_practice
  belongs_to :patient
  has_many :attachment
end
