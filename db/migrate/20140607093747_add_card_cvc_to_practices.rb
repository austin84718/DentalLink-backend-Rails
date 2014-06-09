class AddCardCvcToPractices < ActiveRecord::Migration
  def change
  	add_column :practices, :card_cvc, :string
  end
end
