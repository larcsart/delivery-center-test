class MercadoLivre::PaymentForm < ApplicationForm
  attribute :payment_type, String
  attribute :total_paid_amount, BigDecimal

  validates_presence_of :payment_type, :total_paid_amount
end
