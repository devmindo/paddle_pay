# frozen_string_literal: true

module PaddlePay
  module Product
    module PayLink
      class << self
        def generate(attributes, options = {})
          options[:body] = attributes if attributes.is_a?(::Hash)
          Connection.request("2.0/product/generate_pay_link", options)
        end
      end
    end
  end
end
