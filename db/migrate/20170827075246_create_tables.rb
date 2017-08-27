class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :tables do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :table_type

      t.timestamps
    end
  end
end
