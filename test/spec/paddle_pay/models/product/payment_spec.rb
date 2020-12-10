# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Product::Payment do
  before do
    PaddlePay.config.vendor_id = ENV["PADDLE_VENDOR_ID"]
    PaddlePay.config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
    @payment = PaddlePay::Product::Payment
    path = PaddlePay::Util.convert_class_to_path(@payment.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe "when the refund of a payment is requested" do
    it "should raise an error if the payment refund is invalid" do
      assert_raises PaddlePay::PaddlePayError do
        @payment.refund(1234567)
      end
    end

    it "should return success if the payment refund is valid" do
      response = @payment.refund(10710436)
      assert_instance_of Hash, response
      refute_nil response[:refund_request_id]
    end
  end
end
