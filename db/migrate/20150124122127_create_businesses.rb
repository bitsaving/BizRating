class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.string :owner_name
      t.text :description
      t.string :year_of_establishment
      t.references :category

      t.timestamps null: false
    end
  end
end
