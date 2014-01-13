class User < ActiveRecord::Base
  belongs_to :practice

  validates :first_name, :last_name, :practice_id, :username, presence: true
end
