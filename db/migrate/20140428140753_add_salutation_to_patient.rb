class AddSalutationToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :salutation, :string
  end
end
