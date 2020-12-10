# frozen_string_literal: true

require "faraday"
require "json"

require_relative "paddle_pay/configuration"
require_relative "paddle_pay/connection"
require_relative "paddle_pay/util"
require_relative "paddle_pay/version"
require_relative "paddle_pay/errors/paddle_pay_error"
require_relative "paddle_pay/models/alert/webhook"
require_relative "paddle_pay/models/product/coupon"
require_relative "paddle_pay/models/product/license"
require_relative "paddle_pay/models/product/pay_link"
require_relative "paddle_pay/models/product/payment"
require_relative "paddle_pay/models/product/product"
require_relative "paddle_pay/models/subscription/charge"
require_relative "paddle_pay/models/subscription/modifier"
require_relative "paddle_pay/models/subscription/payment"
require_relative "paddle_pay/models/subscription/plan"
require_relative "paddle_pay/models/subscription/user"
require_relative "paddle_pay/models/transaction/checkout"
require_relative "paddle_pay/models/transaction/order"
require_relative "paddle_pay/models/transaction/product"
require_relative "paddle_pay/models/transaction/subscription"
require_relative "paddle_pay/models/transaction/user"

module PaddlePay
  class << self
    attr_writer :config
  end

  def self.configure
    yield(config) if block_given?
  end

  def self.config
    @config ||= PaddlePay::Configuration.new
  end
end
