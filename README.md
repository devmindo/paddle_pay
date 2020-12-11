# PaddlePay

![Tests](https://github.com/devmindo/paddle_pay/workflows/Tests/badge.svg?branch=master)

A Ruby wrapper for the paddle.com API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paddle_pay'
```

And then execute:

    $ bundle

## Configuration

Configure the gem with the credentials obtained from the Paddle Dashboard

```ruby
PaddlePay.configure do |config|
  config.vendor_id = 'YOUR VENDOR ID'
  config.vendor_auth_code = 'YOUR VENDOR AUTH CODE'
end
```
## Usage

### Product
List all published one-time products associated with your account:
```ruby
PaddlePay::Product.list(filters = {}, options = {})
```

##### Coupons
Return any available coupons valid for a specified one-time product or subscription plan:
```ruby
product_id = 123456
PaddlePay::Product::Coupon.list(product_id, options = {})
```

Create a new coupon for the given product or a checkout:
```ruby
attributes = { coupon_type: 'checkout', discount_type: 'percentage', discount_amount: '20', allowed_uses: 10 }
PaddlePay::Product::Coupon.create(attributes, options = {})
```

Delete a given coupon and prevent it from being further used:
```ruby
coupon_code = 'ABCDEFG'
product_id = 123456
PaddlePay::Product::Coupon.delete(coupon_code, product_id, options = {})
```

Updating a single coupon code:
```ruby
coupon_code = 'ABCDEFG'
attributes = { allowed_uses: 10 }
PaddlePay::Product::Coupon.update_code(coupon_code, attributes = {}, options = {})
```

Updating a group of coupons:
```ruby
group = 'GROUP123'
attributes = { allowed_uses: 10 }
PaddlePay::Product::Coupon.update_group(group, attributes = {}, options = {})
```

##### Pay Links
Set custom attributes for a one-time or subscription checkout link:
```ruby
attributes = { product_id: '123456' }
PaddlePay::Product::PayLink.generate(attributes, options = {})
```

##### Payments
Request a refund for a one-time payment, either in full or partial:
```ruby
order_id = 123456
PaddlePay::Product::Payment.refund(order_id, attributes = {}, options = {})
```

### Subscription

##### Plans
List all of the available subscription plans:
```ruby
PaddlePay::Subscription::Plan.list(filters = {}, options = {})
```

Create a new subscription billing plan:
```ruby
attributes = { plan_name: 'Test', plan_trial_days: 30, plan_length: 1, plan_type: 'month', main_currency_code: 'USD', recurring_price_usd: '5.00' }
PaddlePay::Subscription::Plan.create(attributes, options = {})
```

##### Subscription Users
List all users subscribed to any of your subscription plans:
```ruby
PaddlePay::Subscription::User.list(filters = {}, options = {})
```

Cancel the specified subscription:
```ruby
subscription_id = 1234567
PaddlePay::Subscription::User.cancel(subscription_id, options = {})
```

Update the quantity, price, and/or plan of a user’s subscription:
```ruby
subscription_id = 1234567
attributes = { recurring_price: '10.00', currency: 'USD', quantity: 1, plan_id: 12345 }
PaddlePay::Subscription::User.update(subscription_id, attributes, options = {})
```

Get a preview of subscription changes before they are committed:
```ruby
PaddlePay::Subscription::User.preview_update(subscription_id, attributes, options = {})
```
##### Modifiers
List all the subscription modifiers:
```ruby
PaddlePay::Subscription::Modifier.list(filters = {}, options = {})
```

Add a modifier to a recurring subscription:
```ruby
attributes = { subscription_id: 1234567, modifier_amount: '1.00', modifier_description: 'Test' }
PaddlePay::Subscription::Modifier.create(attributes, options = {})
```

Delete an existing subscription price modifier:
```ruby
modifier_id = 12345
PaddlePay::Subscription::Modifier.delete(modifier_id, options = {})
```

##### Payments
List all paid and upcoming (unpaid) payments:
```ruby
PaddlePay::Subscription::Payment.list(filters = {}, options = {})
```
Change the due date on an upcoming subscription payment:
```ruby
payment_id = 123456
date = '2020-12-31' # in format YYYY-MM-DD
PaddlePay::Subscription::Payment.reschedule(payment_id, date, options = {})
```

Request a refund for a subscription payment, either in full or partial:
```ruby
order_id = 123456
PaddlePay::Subscription::Payment.refund(order_id, attributes = {}, options = {})
```

##### One-off Charges
Make immediate one-time charges on top of an existing subscription:
```ruby
subscription_id = 1234567
amount = '5.00'
charge_name = 'Test'
PaddlePay::Subscription::Charge.create(subscription_id, amount, charge_name, options = {})
```

### Alert

##### Webhooks
Retrieve past events and alerts that Paddle has sent to webhooks on your account:
```ruby
PaddlePay::Alert::Webhook.history(filters = {}, options = {})
```

### Transaction
Retrieve transactions for related entities within Paddle:
##### Checkout
```ruby
id = '123456'
PaddlePay::Transaction::Checkout.list(id, options = {})
```
##### Order
```ruby
id = '123456'
PaddlePay::Transaction::Order.list(id, options = {})
```
##### Product
```ruby
id = '123456'
PaddlePay::Transaction::Product.list(id, options = {})
```
##### Subscription
```ruby
id = '123456'
PaddlePay::Transaction::Subscription.list(id, options = {})
```
##### User
```ruby
id = '123456'
PaddlePay::Transaction::User.list(id, options = {})
```

## Development

Check out the repository and run `bin/setup` to install dependencies. For configuration run `mv .env.template .env` and set your credentials in the required fields. After that, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).