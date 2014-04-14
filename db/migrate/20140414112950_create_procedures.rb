class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :code
      t.string :name
      t.references :practice_type, index: true

      t.timestamps
    end
  end
end
