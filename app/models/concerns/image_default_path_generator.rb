module ImageDefaultPathGenerator

  # extend ActiveSupport::Concern

  # included do
    def image_default_path_for(fields = [], options = {})
      if fields.is_a?(Array) && options.is_a?(Hash) && options[:default_path].present?
        fields.each do |field|
          methods = <<-RUBY
          def field_name
            super || 'options_default_path'
          end
          RUBY
          methods.gsub!('field_name', field.to_s)
          methods.gsub!('options_default_path', options[:default_path].to_s)
          self.class_eval(methods)
        end
      end
    end
  # end



end