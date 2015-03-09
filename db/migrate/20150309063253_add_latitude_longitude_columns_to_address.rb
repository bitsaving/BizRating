class AddLatitudeLongitudeColumnsToAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :area, :string
    add_column :addresses, :longitude, :decimal, precision: 9, scale: 6
    add_column :addresses, :latitude, :decimal, precision: 9, scale: 6
  end
end
