class CreatePracticeInvitations < ActiveRecord::Migration
  def change
    create_table :practice_invitations do |t|
      t.string :practice_name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email
      t.string :contact_phone
      t.references :practice, index: true

      t.timestamps
    end
  end
end
