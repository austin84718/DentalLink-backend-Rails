class RenamePracticeTypeColumn < ActiveRecord::Migration
  def change
    rename_column :practice_types, :type, :code
  end
end
