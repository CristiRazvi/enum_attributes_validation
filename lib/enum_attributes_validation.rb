require 'enum_attributes_validation/version'
require 'active_support'
require 'active_record'

module EnumAttributesValidation
  extend ActiveSupport::Concern

  included do
    attr_writer :enum_invalid_attributes
    def enum_invalid_attributes
      @enum_invalid_attributes ||= {}
    end
    validate :check_enum_invalid_attributes

    private

      def check_enum_invalid_attributes
        if enum_invalid_attributes.present?
          enum_invalid_attributes.each do |key, value|
            errors.add(key, :invalid_enum, value: value, valid_values: self.class.send(key.to_s.pluralize).keys.sort.join(', '), default: "invalid #{value}")
          end
        end
      end
  end

  class_methods do
    def validate_enum_attributes(*attributes)
      attributes.each do |attribute|
        string_attribute = attribute.to_s

        define_method (string_attribute+"=").to_sym do |argument|
          string_argument = argument.to_s
          self[string_attribute] = string_argument                  if self.class.send(string_attribute.pluralize).keys.include?(string_argument)
          self.enum_invalid_attributes[attribute] = string_argument unless self.class.send(string_attribute.pluralize).keys.include?(string_argument)
        end
      end
    end

    def validate_enum_attribute(*attributes)
      self.validate_enum_attributes(*attributes)
    end
  end
end

# include the extension in active record
ActiveRecord::Base.send(:include, EnumAttributesValidation)
