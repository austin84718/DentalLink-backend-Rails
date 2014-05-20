class PracticeType < ActiveRecord::Base
  has_many :practices
  has_many :procedures
end
