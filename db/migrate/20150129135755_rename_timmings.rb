class RenameTimmings < ActiveRecord::Migration
  def change
    rename_table :timmings, :time_slots
  end
end
