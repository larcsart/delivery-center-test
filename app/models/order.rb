class Order < ApplicationRecord

  # Macros: Relations --------------------------------------------------------------------------------------------------
  has_one  :customer, dependent: :destroy
  has_many :items,    dependent: :destroy
  has_many :payments, dependent: :destroy

  accepts_nested_attributes_for :customer, :items, :payments
  # --------------------------------------------------------------------------------------------------------------------


  # Macros: Validations ------------------------------------------------------------------------------------------------
  validates_presence_of :externalCode, :storeId, :subTotal, :deliveryFee, :total, :dtOrderCreate
  validates_presence_of :country, :state, :city, :district, :street, :number, :complement, :postalCode
  validates_presence_of :latitude, :longitude
  validates_presence_of :storeId, :storeId, :storeId, :storeId, :storeId, :storeId
  validates_uniqueness_of :externalCode, scope: :storeId
  # --------------------------------------------------------------------------------------------------------------------


  # Public Instance Methods --------------------------------------------------------------------------------------------
  # Procurei uma customização no activesupport mas não encontrei. Precisaria de mais tempo.
  def as_json(options = nil)
    json = super(options)
    json['dtOrderCreate'] = dtOrderCreate.iso8601(3)
    json['latitude']      = latitude.to_f
    json['longitude']     = longitude.to_f
    json
  end
  # --------------------------------------------------------------------------------------------------------------------

end
