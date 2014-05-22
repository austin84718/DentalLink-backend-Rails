class AddOrigProviderRefToReferral < ActiveRecord::Migration
  def change
    add_reference :referrals, :orig_provider, index: true
  end
end
