# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Configuration do
  before do
    PaddlePay.config.vendor_id = ENV["PADDLE_VENDOR_ID"]
    PaddlePay.config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
  end

  describe "when loading configuration" do
    it "should have a base url" do
      assert !PaddlePay.config.vendors_url.nil?
    end

    it "should have a vendor id" do
      assert !PaddlePay.config.vendor_id.nil?
    end

    it "should have a vendor auth code" do
      assert !PaddlePay.config.vendor_auth_code.nil?
    end
  end
end
