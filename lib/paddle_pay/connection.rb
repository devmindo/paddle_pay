# frozen_string_literal: true

module PaddlePay
  module Connection
    class << self
      def request(url, options = {})
        request_url = PaddlePay.config.vendors_url
        params = options.delete(:params) || {}
        headers = options.delete(:headers) || {}
        body = options.delete(:body) || {}

        conn = Faraday.new(url: request_url) do |faraday|
          faraday.request :url_encoded
          faraday.response :raise_error
          faraday.adapter :net_http
        end

        begin
          response = conn.post(url, config.merge(body)) do |req|
            req.params.merge!(params)
            req.headers.merge!(headers)
          end
          result = parse(response)
          unless result['success']
            raise PaddlePayError.new(result['error']['message'], result['error']['code'])
          end

          PaddlePay::Util.convert_hash_keys(result['response'])
        rescue Faraday::BadRequestError => e
          raise BadRequestError.new(e.response[:body], e.response[:status])
        rescue Faraday::UnauthorizedError => e
          raise UnauthorizedError.new(e.response[:body], e.response[:status])
        rescue Faraday::ForbiddenError => e
          raise ForbiddenError.new(e.response[:body], e.response[:status])
        rescue Faraday::ResourceNotFound => e
          raise ResourceNotFoundError.new(e.response[:body], e.response[:status])
        rescue Faraday::ProxyAuthError => e
          raise ProxyAuthError.new(e.response[:body], e.response[:status])
        rescue Faraday::ConflictError => e
          raise ConflictError.new(e.response[:body], e.response[:status])
        rescue Faraday::UnprocessableEntityError => e
          raise UnprocessableEntityError.new(e.response[:body], e.response[:status])
        rescue Faraday::TimeoutError => e
          raise TimeoutError, 'The connection has timed out'
        rescue Faraday::ConnectionFailed => e
          raise ConnectionError, 'The connection failed'
        rescue Faraday::ServerError => e
          raise ServerError.new(e.response[:body], e.response[:status])
        end
      end

      private

      def parse(response)
        JSON.parse(response.body)
      rescue JSON::ParserError
        raise ParseError, "Invalid response object from API: #{response.body.inspect} " \
                    "(HTTP response code was #{response.status})"
      end

      def config
        {
          vendor_id: PaddlePay.config.vendor_id,
          vendor_auth_code: PaddlePay.config.vendor_auth_code
        }
      end
    end
  end
end
