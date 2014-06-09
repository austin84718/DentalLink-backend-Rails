class Practice < ActiveRecord::Base
  belongs_to :address
  belongs_to :practice_type

  has_many :practice_invitations
  has_many :referrals
  has_many :users

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :address, presence: true, unless: :invited?

  before_save :update_stripe

  private

  def invited?
    status == :invite
  end

  def update_stripe

    if self.stripe_customer_id.nil?
      if !stripe_token.present?
        raise "We're doing something wrong -- this isn't supposed to happen"
      end

      customer = Stripe::Customer.create(
        :email => account_email,
        :description => name,
        :card => stripe_token
      )
      #self.last_4_digits = customer.active_card.last4
      response = customer.update_subscription({:plan => "referral-premium"})
    else
      customer = Stripe::Customer.retrieve(stripe_customer_id)

      if stripe_token.present?
        customer.card = stripe_token
      end

      # in case they've changed
      customer.email = account_email
      customer.description = name

      customer.save

      #self.last_4_digits = customer.active_card.last4
    end

    self.stripe_customer_id = customer.id
    #self.stripe_token = nil
  end
end
