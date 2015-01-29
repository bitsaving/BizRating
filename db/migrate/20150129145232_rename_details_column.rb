class RenameDetailsColumn < ActiveRecord::Migration
  def change
    rename_column :contacts, :details, :info
  end
end
