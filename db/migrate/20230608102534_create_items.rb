class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.float :tax_rate
      t.float :price

      t.timestamps
    end
  end
end
