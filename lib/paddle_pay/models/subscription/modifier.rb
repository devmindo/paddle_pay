# frozen_string_literal: true

module PaddlePay
  module Subscription
    module Modifier
      class << self
        def list(filters = {}, options = {})
          options[:body] = filters if filters.is_a?(::Hash)
          Connection.request("2.0/subscription/modifiers", options)
        end

        def create(attributes, options = {})
          options[:body] = attributes if attributes.is_a?(::Hash)
          Connection.request("2.0/subscription/modifiers/create", options)
        end

        def delete(modifier_id, options = {})
          options[:body] = {modifier_id: modifier_id}
          Connection.request("2.0/subscription/modifiers/delete", options)
        end
      end
    end
  end
end
