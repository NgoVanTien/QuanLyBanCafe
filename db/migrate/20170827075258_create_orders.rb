class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :table, foreign_key: true
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
