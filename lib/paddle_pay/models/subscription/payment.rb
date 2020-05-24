# frozen_string_literal: true

module PaddlePay
  module Subscription
    module Payment
      class << self
        def list(filters = {}, options = {})
          options.merge!({ body: filters }) if filters.is_a?(::Hash)
          Connection.request('2.0/subscription/payments', options)
        end

        def reschedule(payment_id, date, options = {})
          options.merge!({ body: { payment_id: payment_id, date: date } })
          Connection.request('2.0/subscription/payments_reschedule', options)
        end

        def refund(order_id, attributes = {}, options = {})
          attributes.merge!(order_id: order_id)
          options.merge!({ body: attributes })
          Connection.request('2.0/payment/refund', options)
        end
      end
    end
  end
end
