class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :details
      t.string :type
      t.references :business
      t.timestamp null: false
    end
  end
end
