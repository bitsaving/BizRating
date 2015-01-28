class CreateTimmings < ActiveRecord::Migration
  def change
    create_table :timmings do |t|
      t.time :from, null: false
      t.time :to, null: false
      t.text :days, null: false
      t.references :business
      t.timestamp null: false
    end
  end
end
