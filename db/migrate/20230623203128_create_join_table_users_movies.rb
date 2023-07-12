class CreateJoinTableUsersMovies < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :movies do |t|
      t.index [:user_id, :movie_id]
      t.index [:movie_id, :user_id]
    end
  end
end
