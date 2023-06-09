class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.float :discount_rate
      t.integer :item_id
      t.string :offer_type
      t.integer :required_item_id

      t.timestamps
    end
  end
end
