class Patient < ActiveRecord::Base
  belongs_to :address
  has_many :attachment
  has_many :referrals

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
