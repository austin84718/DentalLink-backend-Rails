class ProviderInvitation < ActiveRecord::Base
  belongs_to :inviter, class_name: 'User'
  belongs_to :registered_user, class_name: 'User'
  before_save  :generate_token

  validates :email, uniqueness: true
  validate :user_email_exists, on: :create

  private
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  def user_email_exists
    errors.add(:message, "Provider already exists") if User.exists?(email: self.email)
  end
end
