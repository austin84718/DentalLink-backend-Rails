class AddInviterRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :inviter, index: true
  end
end
