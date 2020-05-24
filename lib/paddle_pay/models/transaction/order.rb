# frozen_string_literal: true

module PaddlePay
  module Transaction
    module Order
      class << self
        def list(id, options = {})
          Connection.request("2.0/order/#{id}/transactions", options)
        end
      end
    end
  end
end
