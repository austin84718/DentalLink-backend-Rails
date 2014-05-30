class AddAccountFieldsToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :salutation, :string
    add_column :practices, :account_first_name, :string
    add_column :practices, :account_last_name, :string
    add_column :practices, :account_middle_initial, :string
  end
end
