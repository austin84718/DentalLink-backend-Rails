class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable,
         :registerable,
         :timeoutable,
         :recoverable,
         :trackable,
         :validatable,
         :confirmable
  belongs_to :practice
  validates :first_name, :last_name, :practice_id, :username, presence: true

  before_save :ensure_authentication_token

  def ensure_authentication_token
    reset_authentication_token if authentication_token.blank?
  end


  def ensure_authentication_token!
    reset_authentication_token! if authentication_token.blank?
  end

  def find_by_authentication_token(authentication_token = nil)
    if authentication_token
      where(authentication_token: authentication_token).first
    end
  end

  def reset_authentication_token!
    reset_authentication_token
    save
  end

  def reset_authentication_token
    self.authentication_token = generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
