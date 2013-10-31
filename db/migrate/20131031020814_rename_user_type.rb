class RenameUserType < ActiveRecord::Migration
  def change
    rename_column :users, :type, :group
  end
end
