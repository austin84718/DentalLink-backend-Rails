class Practice < ActiveRecord::Base
  belongs_to :address
  belongs_to :practice_type

  has_many :practice_invitations
  has_many :referrals
  has_many :users

  validates :name, presence: true
  validates :address, presence: true, unless: :invited?

  private

  def invited?
    status == :invite
  end


end
