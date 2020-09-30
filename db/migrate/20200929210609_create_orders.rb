class CreateOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :orders do |t|
      t.string   :externalCode
      t.string   :storeId
      t.string   :subTotal
      t.string   :deliveryFee
      t.string   :total
      t.datetime :dtOrderCreate, precision: 3
      t.string   :country
      t.string   :state
      t.string   :city
      t.string   :district
      t.string   :street
      t.string   :number
      t.string   :complement
      t.string   :postalCode
      t.decimal  :latitude, precision: 9, scale: 6
      t.decimal  :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
