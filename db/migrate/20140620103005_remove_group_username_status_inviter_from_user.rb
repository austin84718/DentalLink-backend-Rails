class RemoveGroupUsernameStatusInviterFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :group, :string
    remove_column :users, :username, :string
    remove_column :users, :status, :string
    remove_reference :users, :inviter, index: true
  end
end
