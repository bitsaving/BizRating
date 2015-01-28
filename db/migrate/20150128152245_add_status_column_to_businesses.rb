class AddStatusColumnToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :status, :boolean, null: false, default: true
  end
end
