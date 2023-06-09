class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.float :applied_discount
      t.float :applied_tax_rate
      t.float :applied_price

      t.timestamps
    end
  end
end
