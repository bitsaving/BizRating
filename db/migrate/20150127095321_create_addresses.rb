class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :building
      t.string :landmark
      t.string :area
      t.string :city
      t.string :pin_code
      t.string :country
      t.string :state
      t.references :business

      t.timestamps null: false
    end
  end
end
