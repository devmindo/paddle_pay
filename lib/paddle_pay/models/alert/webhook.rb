# frozen_string_literal: true

module PaddlePay
  module Alert
    module Webhook
      class << self
        def history(filters = {}, options = {})
          options.merge!({ body: filters }) if filters.is_a?(::Hash)
          Connection.request('2.0/alert/webhooks', options)
        end
      end
    end
  end
end
