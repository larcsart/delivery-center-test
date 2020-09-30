class MercadoLivre::BuyerForm < ApplicationForm
  attribute :id, Integer
  attribute :first_name, String
  attribute :last_name, String
  attribute :email, String

  attribute :phone, PhoneForm

  validates_presence_of :id, :first_name, :last_name, :email, :phone

  validates :phone, nested_forms: :one

  def full_name
    [first_name, last_name].join(' ').squeeze.upcase
  end
end
