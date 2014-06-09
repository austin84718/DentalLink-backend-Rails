class AddAccountEmailToPractice < ActiveRecord::Migration
  def change
  	add_column :practices, :account_email, :string
  end
end
