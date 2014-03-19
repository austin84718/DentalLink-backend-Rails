class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :message
      t.references :referral, index: true

      t.timestamps
    end
  end
end
