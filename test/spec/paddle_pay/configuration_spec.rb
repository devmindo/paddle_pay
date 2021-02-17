# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Configuration do
  before do
    PaddlePay.config.vendor_id = ENV["PADDLE_VENDOR_ID"]
    PaddlePay.config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
  end

  describe "when loading default configuration" do
    it "should have a base url" do
      assert !PaddlePay.config.vendors_url.nil?
    end

    it "should have a vendor id" do
      assert !PaddlePay.config.vendor_id.nil?
    end

    it "should have a vendor auth code" do
      assert !PaddlePay.config.vendor_auth_code.nil?
    end

    it "should use the production url if no environment is set" do
      assert_equal PaddlePay.config.vendors_url, "https://vendors.paddle.com/api"
    end
  end

  describe "when loading production configuration" do
    before do
      PaddlePay.config.environment = :production
    end

    it "should use the production url" do
      assert_equal PaddlePay.config.vendors_url, "https://vendors.paddle.com/api"
    end
  end

  describe "when loading development configuration" do
    before do
      PaddlePay.config.environment = :development
    end

    after do
      PaddlePay.config.environment = :production
    end

    it "should use the sandbox url" do
      assert_equal PaddlePay.config.vendors_url, "https://sandbox-vendors.paddle.com/api"
    end
  end
end
