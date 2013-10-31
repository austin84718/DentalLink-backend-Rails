class Patient < ActiveRecord::Base
  belongs_to :address
  has_many :attachment
end
