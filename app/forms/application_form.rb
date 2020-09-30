class ApplicationForm
  include ActiveModel::Model
  include Virtus.model
  include ActiveModel::Validations
  extend ActiveModel::Callbacks
end
