class AddStripeTokenToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :stripe_token, :string
  end
end
