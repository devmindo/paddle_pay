# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Alert::Webhook do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @webhook = PaddlePay::Alert::Webhook
    path = PaddlePay::Util.convert_class_to_path(@webhook.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when webhooks are requested' do
    it 'should list all webhooks' do
      response = @webhook.history
      assert_instance_of Hash, response
      refute_nil response[:data]
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @webhook.history
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @webhook.history
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end
end
