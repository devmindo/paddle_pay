# frozen_string_literal: true

module PaddlePay
  module Product
    class << self
      def list(filters = {}, options = {})
        options.merge!({ body: filters }) if filters.is_a?(::Hash)
        Connection.request('2.0/product/get_products', options)
      end
    end
  end
end
