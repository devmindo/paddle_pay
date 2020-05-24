# frozen_string_literal: true

require 'test_helper'

describe PaddlePay::Util do
  describe 'when convert hash keys' do
    it 'should not convert strings' do
      assert_equal PaddlePay::Util.convert_hash_keys('string'), 'string'
    end

    it 'should convert hash keys to snake case' do
      assert_equal PaddlePay::Util.convert_hash_keys({ "testKey": 'test' }), { test_key: 'test' }
    end

    it 'should convert multiple hash keys to snake case' do
      assert_equal PaddlePay::Util.convert_hash_keys({ "testKey": 'test', "secondKey": 'test' }), { test_key: 'test', second_key: 'test' }
    end

    it 'should convert hash keys in arrays to snake case' do
      assert_equal PaddlePay::Util.convert_hash_keys([{ "testKey": 'test' }]), [{ test_key: 'test' }]
    end

    it 'should convert abbreviations to lowercase keys' do
      assert_equal PaddlePay::Util.convert_hash_keys({ "USD": 'test' }), { usd: 'test' }
    end

    it 'should convert multidimensional hashes' do
      assert_equal PaddlePay::Util.convert_hash_keys({ "testKey": { "multiKey": 'test' } }), { test_key: { multi_key: 'test' } }
    end
  end

  describe 'when convert simple class names' do
    it 'should convert class names to snake case' do
      assert_equal PaddlePay::Util.convert_class_to_path('PaddlePay'), 'paddle_pay'
    end

    it 'should convert modules to path' do
      assert_equal PaddlePay::Util.convert_class_to_path('PaddlePay::Util'), 'paddle_pay/util'
    end
  end
end
