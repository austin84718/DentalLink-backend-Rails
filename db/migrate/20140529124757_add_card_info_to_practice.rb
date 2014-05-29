class AddCardInfoToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :card_number, :string
    add_column :practices, :name_on_card, :string
    add_column :practices, :card_exp_month, :integer
    add_column :practices, :card_exp_year, :integer
  end
end
