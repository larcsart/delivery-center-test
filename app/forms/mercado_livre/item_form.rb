class MercadoLivre::ItemForm < ApplicationForm
  attribute :id, Integer
  attribute :title, Integer

  validates_presence_of :id, :title
end
