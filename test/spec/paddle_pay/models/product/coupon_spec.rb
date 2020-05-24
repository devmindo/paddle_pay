# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Product::Coupon do
  before do
    PaddlePay.config.vendor_id = ENV['PADDLE_VENDOR_ID']
    PaddlePay.config.vendor_auth_code = ENV['PADDLE_VENDOR_AUTH_CODE']
    @coupon = PaddlePay::Product::Coupon
    path = PaddlePay::Util.convert_class_to_path(@coupon.name) + "/#{name}"
    VCR.insert_cassette(path)
  end

  after do
    VCR.eject_cassette
  end

  describe 'when coupons are requested' do
    it 'should list all coupons' do
      list = @coupon.list(594469)
      assert_instance_of Array, list
      refute_nil list.first[:coupon] if list.count > 0
    end

    it 'should raise an error if no vendor id is present' do
      PaddlePay.config.vendor_id = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @coupon.list(594469)
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end

    it 'should raise an error if no vendor auth code is present' do
      PaddlePay.config.vendor_auth_code = nil
      exception = assert_raises PaddlePay::PaddlePayError do
        @coupon.list(594469)
      end
      assert_equal exception.code, 107 # You don't have permission to access this resource
    end
  end

  describe 'when the creation of a coupon is requested' do
    it 'should raise an error if the coupon is invalid' do
      coupon = { coupon_type: 'checkout' }
      assert_raises PaddlePay::PaddlePayError do
        @coupon.create(coupon)
      end
    end

    it 'should return coupon codes if the coupon is valid' do
      coupon = { coupon_type: 'checkout', discount_type: 'percentage', discount_amount: '100', allowed_uses: 10 }
      response = @coupon.create(coupon)
      assert_instance_of Hash, response
      refute_nil response[:coupon_codes]
    end
  end

  describe 'when the update of a coupon is requested' do
    it 'should return updated == 0 if the coupon update is invalid' do
      response = @coupon.update_code('NOVALIDCODE', { allowed_uses: 20 })
      assert_instance_of Hash, response
      assert_equal response[:updated], 0
    end

    it 'should return updated > 0 if the coupon update is valid' do
      response = @coupon.update_code('7D0E7A68', { allowed_uses: 20 })
      assert_instance_of Hash, response
      assert_equal response[:updated], 1
    end
  end

  describe 'when the update of a coupon group is requested' do
    it 'should return updated == 0 if the coupon group update is invalid' do
      response = @coupon.update_group('NOVALIDGROUP', { allowed_uses: 20 })
      assert_instance_of Hash, response
      assert_equal response[:updated], 0
    end

    it 'should return updated > 0 if the coupon group update is valid' do
      response = @coupon.update_group('Testgroup', { allowed_uses: 30 })
      assert_instance_of Hash, response
      assert_equal response[:updated], 1
    end
  end

  describe 'when the deletion of a coupon is requested' do
    it 'should raise an error if the coupon deletion is invalid' do
      assert_raises PaddlePay::PaddlePayError do
        @coupon.delete('NOVALIDCOUPON', 594470)
      end
    end

    it 'should return success if the coupon deletion is valid' do
      response = @coupon.delete('9F9F78DA', 594470)
      assert_nil response # no response when request is successful
    end
  end
end
