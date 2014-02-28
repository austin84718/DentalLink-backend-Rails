class Practice < ActiveRecord::Base
  belongs_to :address
  has_many :practice_invitations
  has_many :referrals

  validates :name, presence: true
  validates :address, presence: true, unless: :invited?

  private

  def invited?
    status == :invite
  end


end
