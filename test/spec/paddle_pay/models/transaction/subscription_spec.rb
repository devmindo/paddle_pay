# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Transaction::Subscription do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @subscription = PaddlePay::Transaction::Subscription
    path = PaddlePay::Util.convert_class_to_path(@subscription.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when subscriptions are requested' do
    it 'should list all subscriptions' do
      list = @subscription.list(3_484_448)
      assert_instance_of Array, list
      refute_nil list.first[:subscription] if list.count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @subscription.list(3_484_448)
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @subscription.list(3_484_448)
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end
end
