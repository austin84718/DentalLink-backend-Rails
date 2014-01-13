class Practice < ActiveRecord::Base
  belongs_to :address

  validates :name, :address_id, presence: true
end
