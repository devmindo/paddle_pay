# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Subscription::User do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @user = PaddlePay::Subscription::User
    path = PaddlePay::Util.convert_class_to_path(@user.name) + "/#{name}"
    puts path
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when users are requested' do
    it 'should list all users' do
      list = @user.list
      assert_instance_of Array, list
      refute_nil list.first[:user_id] if list.count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @user.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @user.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end

  describe 'when an update preview is requested' do
    it 'should raise an error if the subscription update preview is invalid' do
      subscription = {}
      assert_raises PaddlePay::PaddlePayError do
        @user.preview_update(3479984, subscription)
      end
    end

    it 'should return a subscription id if the subscription update preview is valid' do
      subscription = { recurring_price: '10.00', currency: 'USD', quantity: 1 }
      response = @user.preview_update(3479984, subscription)
      assert_instance_of Hash, response
      refute_nil response[:subscription_id]
    end
  end

  describe 'when an update is requested' do
    it 'should raise an error if the subscription update is invalid' do
      subscription = {}
      assert_raises PaddlePay::PaddlePayError do
        @user.update(3479984, subscription)
      end
    end

    it 'should return a subscription id if the subscription update is valid' do
      subscription = { recurring_price: '10.00', currency: 'USD', quantity: 1 }
      response = @user.update(3479984, subscription)
      assert_instance_of Hash, response
      refute_nil response[:subscription_id]
    end
  end

  describe 'when a cancelation is requested' do
    it 'should raise an error if the cancelation is invalid' do
      assert_raises PaddlePay::PaddlePayError do
        @user.cancel(1000000, {})
      end
    end

    it 'should return success if the cancelation is valid' do
      response = @user.cancel(3479984)
      assert_nil response # no response when request is successful
    end
  end
end
