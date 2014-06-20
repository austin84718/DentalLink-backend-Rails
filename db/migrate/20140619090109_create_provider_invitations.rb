class CreateProviderInvitations < ActiveRecord::Migration
  def change
    create_table :provider_invitations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :token
      t.string :status
      t.references :inviter, index: true
      t.references :registered_user, index: true
      t.timestamps
    end
  end
end
