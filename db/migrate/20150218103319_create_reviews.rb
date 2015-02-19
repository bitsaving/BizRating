class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :business, index: true
      t.belongs_to :user, index: true
      t.text :detail
      t.integer :rating
      t.timestamps null: false
    end
  end
end
