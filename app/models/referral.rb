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

  accepts_nested_attributes_for :notes

  validates :orig_practice_id, :orig_provider_id, :dest_provider_id, :patient_id, :procedure_id, presence: true


end
