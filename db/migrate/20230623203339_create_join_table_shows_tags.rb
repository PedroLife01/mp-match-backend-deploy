class CreateJoinTableShowsTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :shows, :tags do |t|
      t.index [:show_id, :tag_id]
      t.index [:tag_id, :show_id]
    end
  end
end
