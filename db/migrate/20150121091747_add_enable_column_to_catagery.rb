class AddEnableColumnToCatagery < ActiveRecord::Migration
  def change
    add_column :categories, :status, :boolean, null:false, default: true
  end
end
