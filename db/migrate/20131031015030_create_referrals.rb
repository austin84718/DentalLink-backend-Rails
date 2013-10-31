class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.references :orig_practice, index: true
      t.references :dest_practice, index: true
      t.references :patient, index: true
      t.text :memo

      t.timestamps
    end
  end
end
