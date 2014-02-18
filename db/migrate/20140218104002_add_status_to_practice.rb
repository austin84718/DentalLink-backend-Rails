class AddStatusToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :status, :string
  end
end
