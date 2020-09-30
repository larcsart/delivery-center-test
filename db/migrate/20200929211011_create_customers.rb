class CreateCustomers < ActiveRecord::Migration[4.2]
  def change
    create_table :customers do |t|
      t.integer :order_id

      t.string :externalCode
      t.string :name
      t.string :email
      t.string :contact

      t.timestamps
    end

    add_foreign_key :customers, :orders
  end
end
