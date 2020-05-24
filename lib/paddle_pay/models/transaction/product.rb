# frozen_string_literal: true

module PaddlePay
  module Transaction
    module Product
      class << self
        def list(id, options = {})
          Connection.request("2.0/product/#{id}/transactions", options)
        end
      end
    end
  end
end
