# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Transaction::Order do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @order = PaddlePay::Transaction::Order
    path = PaddlePay::Util.convert_class_to_path(@order.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when orders are requested' do
    it 'should list all orders' do
      list = @order.list('14854225-10710435')
      assert_instance_of Array, list
      refute_nil list.first[:order_id] if list.count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @order.list('14854225-10710435')
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @order.list('14854225-10710435')
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end
end
