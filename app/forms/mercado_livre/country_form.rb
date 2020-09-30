class MercadoLivre::CountryForm < ApplicationForm
  attribute :id, String

  validates_presence_of :id
end
