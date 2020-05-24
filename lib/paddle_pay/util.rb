# frozen_string_literal: true

module PaddlePay
  module Util
    class << self
      def convert_hash_keys(value)
        case value
        when Array
          value.map { |v| convert_hash_keys(v) }
        when Hash
          Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
        else
          value
        end
      end

      def convert_class_to_path(class_name)
        class_name.split('::').map { |v| to_snake_case(v) }.join('/')
      end

      private

      def underscore_key(k)
        to_snake_case(k.to_s).to_sym
      end

      def to_snake_case(string)
        string.gsub(/::/, '/')
              .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
              .tr('-', '_')
              .downcase
      end
    end
  end
end
