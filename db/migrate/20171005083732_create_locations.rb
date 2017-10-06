class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.integer :row, default: 10
      t.integer :column, default: 10
      
      t.timestamps
    end
  end
end
