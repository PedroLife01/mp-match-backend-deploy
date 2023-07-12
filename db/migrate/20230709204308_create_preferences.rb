class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.text :movie
      t.text :book
      t.text :show

      t.timestamps
    end
  end
end
