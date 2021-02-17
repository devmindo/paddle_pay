# frozen_string_literal: true

# based off of stripe gem: https://github.com/stripe/stripe-ruby
module PaddlePay
  class PaddlePayError < StandardError
    attr_reader :code
    attr_reader :message

    def initialize(message, code = nil)
      super("#{message} #{"(Code " + code.to_s + ")" if code}")
      @code = code
      @message = message
    end
  end

  class ClientError < PaddlePayError
  end

  class BadRequestError < ClientError
  end

  class UnauthorizedError < ClientError
  end

  class ForbiddenError < ClientError
  end

  class ResourceNotFoundError < ClientError
  end

  class ProxyAuthError < ClientError
  end

  class ConflictError < ClientError
  end

  class UnprocessableEntityError < ClientError
  end

  class ArgumentError < ClientError
  end

  class ServerError < PaddlePayError
  end

  class LimitExceededError < ServerError
  end

  class ConnectionError < ServerError
  end

  class TimeoutError < ServerError
  end

  class ParseError < ServerError
  end
end
