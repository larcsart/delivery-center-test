class NestedFormsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    current_value = record.send(attribute)
    if current_value.present?
      if options.try(:[], :with) == :many
        current_value.each_with_index do |_, k|
          record.errors.add(:"#{attribute}_#{k}", current_value[k].errors.messages) unless current_value[k].valid?
        end
      elsif options.try(:[], :with) == :one
        record.errors.add(:"#{attribute}", current_value.errors.messages) unless current_value.valid?
      end
    end
  end
end
