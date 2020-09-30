class Item < ApplicationRecord

  # Macros: Relations --------------------------------------------------------------------------------------------------
  belongs_to :order
  has_many :subItems, class_name: 'Item', foreign_key: :subItem_id
  belongs_to :item, class_name: 'Item', foreign_key: :subItem_id, required: false

  accepts_nested_attributes_for :subItems
  # --------------------------------------------------------------------------------------------------------------------


  # Macros: Validations ------------------------------------------------------------------------------------------------
  validates_presence_of :externalCode, :name, :price, :quantity, :total
  validates_numericality_of :price, :quantity, :total, greater_than_or_equal_to: 0
  # --------------------------------------------------------------------------------------------------------------------


  # Public Instance Methods --------------------------------------------------------------------------------------------
  # Procurei uma customização no activesupport mas não encontrei. Precisaria de mais tempo.
  def as_json(options = nil)
    json = super(options)
    json['price'] = price.to_f
    json['total'] = total.to_f
    json
  end
  # --------------------------------------------------------------------------------------------------------------------

end
