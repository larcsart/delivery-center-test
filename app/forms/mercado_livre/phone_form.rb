class MercadoLivre::PhoneForm < ApplicationForm
  attribute :area_code, Integer
  attribute :number, String

  validates_presence_of :area_code, :number

  def full_number
    [area_code, number].join('')
  end
end
