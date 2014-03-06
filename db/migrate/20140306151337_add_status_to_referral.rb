class AddStatusToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :status, :text
  end
end
