class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.string :title
      t.string :first_name
      t.string :middle_initial, limit: 1
      t.string :last_name
      t.string :username
      t.string :password
      t.references :practice, index: true

      t.timestamps
    end
  end
end
