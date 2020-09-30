class MercadoLivre::ShippingForm < ApplicationForm
  attribute :receiver_address, AddressForm

  validates_presence_of :receiver_address

  validates :receiver_address, nested_forms: :one
end
