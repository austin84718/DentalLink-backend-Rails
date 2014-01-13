class Address < ActiveRecord::Base
  has_one :practice
  has_one :patient

  validates :street_line_1, :city, :state, :zip, presence: true
end
