class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :businesses, :category_id
    add_index :addresses, :business_id
    add_index :contacts, :business_id
    add_index :images, :business_id
    add_index :time_slots, :business_id
    add_index :businesses_keywords, [:business_id, :keyword_id]
  end
end
