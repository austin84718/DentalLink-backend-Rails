class Practice < ActiveRecord::Base
  belongs_to :address

  validates :name, :address, presence: true
end
