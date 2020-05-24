# frozen_string_literal: true

module PaddlePay
  module Transaction
    module Subscription
      class << self
        def list(id, options = {})
          Connection.request("2.0/subscription/#{id}/transactions", options)
        end
      end
    end
  end
end
