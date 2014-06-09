class AddStripeCustomerIdToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :stripe_customer_id, :string
  end
end
