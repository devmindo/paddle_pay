# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Subscription::Plan do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @plan = PaddlePay::Subscription::Plan
    path = PaddlePay::Util.convert_class_to_path(@plan.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when plans are requested' do
    it 'should list all plans' do
      list = @plan.list
      assert_instance_of Array, list
      refute_nil list.first[:id] if list.count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @plan.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @plan.list
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end

  describe 'when the creation of a plan is requested' do
    it 'should raise an error if the plan is invalid' do
      plan = { plan_name: 'Test', plan_trial_days: 30, plan_length: 1, plan_type: 'month' }
      assert_raises PaddlePay::PaddlePayError do
        @plan.create(plan)
      end
    end

    it 'should return a product id if the plan is valid' do
      plan = { plan_name: 'Test', plan_trial_days: 30, plan_length: 1, plan_type: 'month', main_currency_code: 'USD', recurring_price_usd: '5.00' }
      response = @plan.create(plan)
      assert_instance_of Hash, response
      refute_nil response[:product_id]
    end
  end
end
