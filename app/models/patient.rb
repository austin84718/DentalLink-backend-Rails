class Patient < ActiveRecord::Base
  belongs_to :address
  has_many :attachment

  validates :first_name, :last_name, presence: true
end
