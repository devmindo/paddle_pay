# frozen_string_literal: true

module PaddlePay
  module Product
    module Coupon
      class << self
        def list(product_id, options = {})
          options.merge!({ body: { product_id: product_id } })
          Connection.request('2.0/product/list_coupons', options)
        end

        def create(attributes, options = {})
          options.merge!({ body: attributes }) if attributes.is_a?(::Hash)
          Connection.request('2.1/product/create_coupon', options)
        end

        def delete(coupon_code, product_id, options = {})
          options.merge!({ body: { coupon_code: coupon_code, product_id: product_id } })
          Connection.request('2.0/product/delete_coupon', options)
        end

        def update_code(coupon_code, attributes = {}, options = {})
          attributes.merge!(coupon_code: coupon_code)
          options.merge!({ body: attributes })
          Connection.request('2.1/product/update_coupon', options)
        end

        def update_group(group, attributes = {}, options = {})
          attributes.merge!(group: group)
          options.merge!({ body: attributes })
          Connection.request('2.1/product/update_coupon', options)
        end
      end
    end
  end
end
