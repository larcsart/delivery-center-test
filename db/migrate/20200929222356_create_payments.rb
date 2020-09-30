class CreatePayments < ActiveRecord::Migration[4.2]
  def change
    create_table :payments do |t|
      t.integer :order_id

      t.string  :payment_type
      t.decimal :value, precision: 9, scale: 2

      t.timestamps
    end

    add_foreign_key :payments, :orders
  end
end
