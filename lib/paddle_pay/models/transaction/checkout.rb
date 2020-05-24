# frozen_string_literal: true

module PaddlePay
  module Transaction
    module Checkout
      class << self
        def list(id, options = {})
          Connection.request("2.0/checkout/#{id}/transactions", options)
        end
      end
    end
  end
end
