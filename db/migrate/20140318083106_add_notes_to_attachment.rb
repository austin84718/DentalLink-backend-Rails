class AddNotesToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :notes, :text
  end
end
