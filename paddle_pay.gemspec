# frozen_string_literal: true

# Maintain your gem's version:
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paddle_pay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "paddle_pay"
  s.version = PaddlePay::VERSION
  s.summary = "A Ruby wrapper for the paddle.com API"
  s.description = "A Ruby wrapper for the paddle.com API"
  s.authors = ["Nicolas Metzger"]
  s.homepage = "https://github.com/devmindo/paddle_pay"
  s.license = "MIT"

  s.files = Dir["lib/**/*", "LICENSE", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.4"

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "dotenv", "~> 2.7"
  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "minitest-reporters", "~> 1.1"
  s.add_development_dependency "vcr", "~> 5.0"
  s.add_development_dependency "webmock", "~> 3.0"

  s.add_runtime_dependency "faraday", "~> 1.0"
  s.add_runtime_dependency "json", "~> 2.0"
end
