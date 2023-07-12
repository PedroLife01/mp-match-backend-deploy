class AddDirectorToShow < ActiveRecord::Migration[7.0]
  def change
    add_column :shows, :director, :string
  end
end
