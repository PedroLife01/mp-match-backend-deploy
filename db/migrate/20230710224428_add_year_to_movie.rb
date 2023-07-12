class AddYearToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :year, :integer
  end
end
