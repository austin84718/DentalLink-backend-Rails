class AddPracticeTypeToPractice < ActiveRecord::Migration
  def change
    add_reference :practices, :practice_type, index: true
  end
end
