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

  has_many :referrals
  has_many :invitees , class_name: 'UserInvitation', foreign_key: 'inviter_id'


  validates :first_name, :last_name, :practice_id, presence: true


  before_save :ensure_authentication_token

  ROLES = %i[admin doctor aux]
  #attr_accessible :roles

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role)
  end


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
