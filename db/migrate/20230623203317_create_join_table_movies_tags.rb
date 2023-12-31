class CreateJoinTableMoviesTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :movies, :tags do |t|
      t.index [:movie_id, :tag_id]
      t.index [:tag_id, :movie_id]
    end
  end
end
