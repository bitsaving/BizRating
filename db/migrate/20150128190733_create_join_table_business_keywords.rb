class CreateJoinTableBusinessKeywords < ActiveRecord::Migration
  def change
    create_join_table :businesses, :keywords do |t|
      # t.index [:business_id, :keyword_id]
      # t.index [:keyword_id, :business_id]
    end
  end
end
