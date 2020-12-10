# frozen_string_literal: true

module PaddlePay
  module Product
    module License
      class << self
        def generate(attributes, options = {})
          options[:body] = attributes if attributes.is_a?(::Hash)
          Connection.request("2.0/product/generate_license", options)
        end
      end
    end
  end
end
