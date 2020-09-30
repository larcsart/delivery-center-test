class CreateItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.integer :order_id

      t.string   :externalCode
      t.string   :name
      t.decimal  :price, precision: 9, scale: 2
      t.integer  :quantity
      t.decimal  :total, precision: 9, scale: 2
      t.integer  :subItem_id

      t.timestamps
    end

    add_foreign_key :items, :orders
  end
end
