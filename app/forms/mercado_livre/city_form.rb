class MercadoLivre::CityForm < ApplicationForm
  attribute :name, String

  validates_presence_of :name
end
