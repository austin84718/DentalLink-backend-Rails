class AddEmailPhoneBirthdateToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :email, :string
    add_column :patients, :phone, :string
    add_column :patients, :birthday, :date
  end
end
