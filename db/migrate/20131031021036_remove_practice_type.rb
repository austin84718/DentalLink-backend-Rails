class RemovePracticeType < ActiveRecord::Migration
  def up
    remove_column :practices, :type
  end

  def down
    add_column :practices, :type
  end
end
