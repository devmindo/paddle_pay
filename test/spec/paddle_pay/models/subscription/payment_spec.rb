# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Subscription::Payment do
  before do
    PaddlePay.config.vendor_id = ENV["PADDLE_VENDOR_ID"]
    PaddlePay.config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
    @payment = PaddlePay::Subscription::Payment
    path = PaddlePay::Util.convert_class_to_path(@payment.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe "when payments are requested" do
    it "should list all payments" do
      list = @payment.list
      assert_instance_of Array, list
      refute_nil list.first[:id] if list.count > 0
    end

    it "should raise an error if no vendor id is present" do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises(PaddlePay::PaddlePayError) { @payment.list }
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it "should raise an error if no vendor auth code is present" do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises(PaddlePay::PaddlePayError) { @payment.list }
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end

  describe "when the reschedule of a payment is requested" do
    it "should raise an error if the payment reschedule is invalid" do
      assert_raises PaddlePay::PaddlePayError do
        @payment.reschedule(10710436, "wrong date")
      end
    end

    it "should return success if the payment reschedule is valid" do
      response = @payment.reschedule(10710436, "2020-12-31")
      assert_nil response # no response when request is successful
    end
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
