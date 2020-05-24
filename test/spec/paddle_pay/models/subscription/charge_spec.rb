# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Subscription::Charge do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @charge = PaddlePay::Subscription::Charge
    path = PaddlePay::Util.convert_class_to_path(@charge.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when a charge is created' do
    it 'should raise an error if the charge is invalid' do
      assert_raises PaddlePay::PaddlePayError do
        @charge.create(12345678, '0.00', 'Test')
      end
    end

    it 'should return invoice id if the charge is valid' do
      response = @charge.create(3484448, '0.00', 'Test')
      assert_instance_of Hash, response
      refute_nil response[:invoice_id]
    end
  end
end
