# frozen_string_literal: true

module PaddlePay
  class Configuration
    attr_reader :vendors_url
    attr_reader :vendor_auth_code
    attr_reader :vendor_id

    def initialize
      @vendors_url = 'https://vendors.paddle.com/api'
    end

    attr_writer :vendor_auth_code

    attr_writer :vendor_id
  end
end
