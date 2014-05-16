class AddTeethToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :teeth, :string
  end
end
