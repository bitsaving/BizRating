class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
    Role.reset_column_information
    Role.create(name: 'admin')
    Role.create(name: 'user')
  end
end
