class AddAddressToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :address_id, :integer
  end
end
