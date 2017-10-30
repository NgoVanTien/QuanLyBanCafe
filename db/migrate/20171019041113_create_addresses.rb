class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :location, foreign_key: true
      t.integer :row_index
      t.integer :col_index
      t.integer :colspan
      t.integer :rowspan
      t.integer :item

      t.timestamps
    end
  end
end
