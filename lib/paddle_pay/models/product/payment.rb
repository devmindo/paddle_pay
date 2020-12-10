# frozen_string_literal: true

module PaddlePay
  module Product
    module Payment
      class << self
        def refund(order_id, attributes = {}, options = {})
          attributes[:order_id] = order_id
          options[:body] = attributes
          Connection.request("2.0/payment/refund", options)
        end
      end
    end
  end
end
