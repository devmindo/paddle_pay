# frozen_string_literal: true

module PaddlePay
  module Subscription
    module Charge
      class << self
        def create(subscription_id, amount, charge_name, options = {})
          options.merge!({ body: { amount: amount, charge_name: charge_name } })
          Connection.request("2.0/subscription/#{subscription_id}/charge", options)
        end
      end
    end
  end
end
