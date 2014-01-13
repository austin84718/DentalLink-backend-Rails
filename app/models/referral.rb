class Referral < ActiveRecord::Base
  belongs_to :orig_practice
  belongs_to :dest_practice
  belongs_to :patient
  has_many :attachment

  validates :orig_practice_id, :dest_practice_id, :patient_id, presence: true


end
