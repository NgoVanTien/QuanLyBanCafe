class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :code
      t.string :name
      t.string :description
      t.float :price, default: 0.0
      t.string :unit

      t.timestamps
    end
  end
end
