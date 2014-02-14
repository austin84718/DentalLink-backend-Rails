class Practice < ActiveRecord::Base
  belongs_to :address
  has_many :practice_invitations

  validates :name, :address, presence: true
end
