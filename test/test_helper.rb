# frozen_string_literal: true

require "dotenv/load"
require "minitest/autorun"
require "minitest/spec"
require "minitest/reporters"
require "webmock/minitest"
require "vcr"
require "paddle_pay"

Minitest::Reporters.use!

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<VENDOR_ID>") { ENV["PADDLE_VENDOR_ID"] }
  config.filter_sensitive_data("<VENDOR_AUTH_CODE>") { ENV["PADDLE_VENDOR_AUTH_CODE"] }
end
