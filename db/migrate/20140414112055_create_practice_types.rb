class CreatePracticeTypes < ActiveRecord::Migration
  def change
    create_table :practice_types do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
