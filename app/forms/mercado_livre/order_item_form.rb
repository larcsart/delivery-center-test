class MercadoLivre::OrderItemForm < ApplicationForm
  attribute :quantity, Integer
  attribute :unit_price, BigDecimal

  attribute :item, ItemForm

  validates_presence_of :quantity, :unit_price, :item

  validates :item, nested_forms: :one

  delegate :id, :title, to: :item, prefix: :item

  def total
    quantity * unit_price rescue 0
  end
end
