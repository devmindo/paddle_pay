# frozen_string_literal: true

module PaddlePay
  module Subscription
    module User
      class << self
        def list(filters = {}, options = {})
          options.merge!({ body: filters }) if filters.is_a?(::Hash)
          Connection.request('2.0/subscription/users', options)
        end

        def cancel(subscription_id, options = {})
          options.merge!({ body: { subscription_id: subscription_id } })
          Connection.request('2.0/subscription/users_cancel', options)
        end

        def update(subscription_id, attributes = {}, options = {})
          attributes.merge!(subscription_id: subscription_id)
          options.merge!({ body: attributes })
          Connection.request('2.0/subscription/users_update', options)
        end

        def preview_update(subscription_id, attributes = {}, options = {})
          attributes.merge!(subscription_id: subscription_id)
          options.merge!({ body: attributes })
          Connection.request('2.0/subscription/preview_update', options)
        end
      end
    end
  end
end
