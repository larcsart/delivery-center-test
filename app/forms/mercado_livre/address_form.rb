class MercadoLivre::AddressForm < ApplicationForm
  attribute :zip_code, String
  attribute :street_name, String
  attribute :street_number, String
  attribute :comment, String

  attribute :country, CountryForm
  attribute :state, StateForm
  attribute :city, CityForm
  attribute :neighborhood, NeighborhoodForm

  attribute :latitude, BigDecimal
  attribute :longitude, BigDecimal

  validates_presence_of :zip_code, :street_name, :street_number, :comment
  validates_presence_of :country, :state, :city, :neighborhood
  validates_presence_of :latitude, :longitude

  validates :country, :state, :city, :neighborhood, nested_forms: :one
end
