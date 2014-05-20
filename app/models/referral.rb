class Referral < ActiveRecord::Base
  include MailHelper
  belongs_to :orig_practice, class_name: 'Practice'
  belongs_to :dest_practice, class_name: 'Practice'

  belongs_to :orig_provider, class_name: 'User'
  belongs_to :dest_provider, class_name: 'User'
  belongs_to :procedure

  belongs_to :patient
  has_many :attachments
  has_many :notes

  validates :orig_practice_id, :dest_practice_id, :patient_id, presence: true


end
