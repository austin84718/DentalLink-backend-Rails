class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :filename
      t.string :description
      t.references :patient, index: true
      t.references :referral, index: true

      t.timestamps
    end
  end
end
