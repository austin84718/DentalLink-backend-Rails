class AddMiddleInitialToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :middle_initial, :string, limit: 1
  end
end
