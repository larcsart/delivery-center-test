class MercadoLivre::OrderForm < ApplicationForm
  attribute :id,           Integer
  attribute :store_id,     Integer
  attribute :date_created, DateTime

  attribute :total_amount,               Float
  attribute :total_shipping,             Float
  attribute :total_amount_with_shipping, Float

  attribute :order_items, Array[OrderItemForm]
  attribute :shipping,    ShippingForm
  attribute :buyer,       BuyerForm
  attribute :payments,    Array[PaymentForm]

  validates_presence_of :id, :store_id, :total_amount, :total_shipping, :total_amount_with_shipping, :shipping
  validates_presence_of :order_items, :shipping, :buyer, :payments

  validates :order_items, :payments, nested_forms: :many
  validates :shipping, :buyer, nested_forms: :one

  def serialize
    {
      externalCode:        id,
      storeId:             store_id,
      subTotal:            total_amount,
      deliveryFee:         total_shipping,
      total:               total_amount_with_shipping,
      dtOrderCreate:       date_created,
      country:             shipping&.receiver_address&.country&.id,
      state:               shipping&.receiver_address&.state&.name,
      city:                shipping&.receiver_address&.city&.name,
      district:            shipping&.receiver_address&.neighborhood&.name,
      street:              shipping&.receiver_address&.street_name,
      number:              shipping&.receiver_address&.street_number,
      complement:          shipping&.receiver_address&.comment,
      postalCode:          shipping&.receiver_address&.zip_code,
      latitude:            shipping&.receiver_address&.latitude,
      longitude:           shipping&.receiver_address&.longitude,
      customer_attributes: get_customer,
      items_attributes:    get_items,
      payments_attributes: get_payments
    }
  end

  def get_customer
    {
      externalCode: buyer&.id,
      name:         buyer&.full_name,
      email:        buyer&.email,
      contact:      buyer&.phone&.full_number
    }
  end

  def get_items
    order_items.map do |order_item|
      {
        externalCode: order_item&.item&.id,
        name:         order_item&.item&.title,
        price:        order_item&.unit_price,
        quantity:     order_item&.quantity,
        total:        order_item&.total,
        subItems:     []
      }
    end
  end

  def get_payments
    payments.map do |payment|
      {
        type:  payment&.payment_type,
        value: payment&.total_paid_amount
      }
    end
  end
end
