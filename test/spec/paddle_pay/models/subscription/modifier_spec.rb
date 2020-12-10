# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Subscription::Modifier do
  before do
    PaddlePay.config.vendor_id = ENV["PADDLE_VENDOR_ID"]
    PaddlePay.config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
    @modifier = PaddlePay::Subscription::Modifier
    path = PaddlePay::Util.convert_class_to_path(@modifier.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe "when modifiers are requested" do
    it "should list all modifiers" do
      list = @modifier.list
      assert_instance_of Array, list
      refute_nil list.first[:modifier_id] if list.count > 0
    end

    it "should raise an error if no vendor id is present" do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises(PaddlePay::PaddlePayError) { @modifier.list }
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it "should raise an error if no vendor auth code is present" do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises(PaddlePay::PaddlePayError) { @modifier.list }
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end

  describe "when the creation of a modifier is requested" do
    it "should raise an error if the modifier is invalid" do
      modifier = {subscription_id: 1234567, modifier_amount: "1.00", modifier_description: "Test"}
      assert_raises PaddlePay::PaddlePayError do
        @modifier.create(modifier)
      end
    end

    it "should return a modifier id if the modifier is valid" do
      modifier = {subscription_id: 3484448, modifier_amount: "1.00", modifier_description: "Test"}
      response = @modifier.create(modifier)
      assert_instance_of Hash, response
      refute_nil response[:modifier_id]
    end
  end

  describe "when the deletion of a modifier is requested" do
    it "should raise an error if the modifier deletion is invalid" do
      assert_raises PaddlePay::PaddlePayError do
        @modifier.delete(1234567)
      end
    end

    it "should return a product id if the modifier deletion is valid" do
      response = @modifier.delete(143433)
      assert_nil response # no response when request is successful
    end
  end
end
