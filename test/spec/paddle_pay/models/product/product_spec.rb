# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Product do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @product = PaddlePay::Product
    path = PaddlePay::Util.convert_class_to_path(@product.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when products are requested' do
    it 'should list all products' do
      list = @product.list
      assert_instance_of Hash, list
      assert_instance_of Array, list[:products]
      refute_nil list[:products].first[:id] if list[:products].count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @product.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @product.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end
end
