class AddPhoneAndWebsiteToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :phone, :string
    add_column :addresses, :website, :string
  end
end
