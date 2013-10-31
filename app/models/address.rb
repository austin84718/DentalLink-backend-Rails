class Address < ActiveRecord::Base
  has_one :practice
  has_one :patient
end
