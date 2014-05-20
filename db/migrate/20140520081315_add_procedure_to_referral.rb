class AddProcedureToReferral < ActiveRecord::Migration
  def change
    add_reference :referrals, :procedure, index: true
  end
end
