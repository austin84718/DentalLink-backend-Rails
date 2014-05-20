class AddDestProviderRefToReferral < ActiveRecord::Migration
  def change
    add_reference :referrals, :dest_provider, index: true
  end
end
