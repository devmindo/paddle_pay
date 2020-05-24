# frozen_string_literal: true

module PaddlePay
  module Transaction
    module User
      class << self
        def list(id, options = {})
          Connection.request("2.0/user/#{id}/transactions", options)
        end
      end
    end
  end
end
