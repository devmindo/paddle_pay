# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Product::PayLink do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @pay_link = PaddlePay::Product::PayLink
    path = PaddlePay::Util.convert_class_to_path(@pay_link.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when a pay link generation is requested' do
    it 'should raise an error if pay link generation request is invalid' do
      pay_link = { product_id: 'NOTVALID' }
      assert_raises PaddlePay::PaddlePayError do
        @pay_link.generate(pay_link)
      end
    end

    it 'should return an url if pay link generation request is valid' do
      pay_link = { product_id: '594512' }
      response = @pay_link.generate(pay_link)
      assert_instance_of Hash, response
      refute_nil response[:url]
    end
  end
end
