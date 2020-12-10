# frozen_string_literal: true

module PaddlePay
  module Subscription
    module Plan
      class << self
        def list(filters = {}, options = {})
          options[:body] = filters if filters.is_a?(::Hash)
          Connection.request("2.0/subscription/plans", options)
        end

        def create(attributes, options = {})
          options[:body] = attributes if attributes.is_a?(::Hash)
          Connection.request("2.0/subscription/plans_create", options)
        end
      end
    end
  end
end
