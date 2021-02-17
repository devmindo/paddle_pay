# frozen_string_literal: true

module PaddlePay
  class Configuration
    attr_reader :environment
    attr_accessor :vendor_auth_code
    attr_accessor :vendor_id

    def initialize
      @environment ||= :production
    end

    def environment=(env)
      env = env.to_sym
      unless [:development, :sandbox, :production].include?(env)
        raise ArgumentError, "#{env.inspect} is not a valid environment"
      end
      @environment = env
    end

    def vendors_url
      case @environment
      when :production
        "https://vendors.paddle.com/api"
      when :development, :sandbox
        "https://sandbox-vendors.paddle.com/api"
      end
    end
  end
end
