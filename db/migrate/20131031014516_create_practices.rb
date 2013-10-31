class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :type
      t.string :name
      t.string :description
      t.references :address, index: true

      t.timestamps
    end
  end
end
