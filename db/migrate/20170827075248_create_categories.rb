class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
