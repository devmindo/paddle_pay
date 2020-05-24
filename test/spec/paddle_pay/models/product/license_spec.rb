# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Product::License do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @license = PaddlePay::Product::License
    path = PaddlePay::Util.convert_class_to_path(@license.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when a license generation is requested' do
    it 'should raise an error if license generation request is invalid' do
      license = { product_id: '594512', allowed_uses: 10 }
      assert_raises PaddlePay::PaddlePayError do
        @license.generate(license)
      end
    end

    it 'should return a license code if license generation request is valid' do
      license = { product_id: '594512', allowed_uses: 10 }
      response = @license.generate(license)
      assert_instance_of Hash, response
      refute_nil response[:license_code]
    end
  end
end
