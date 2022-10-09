# frozen_string_literal: true

module PaddlePay
  module Connection
    class << self
      def request(url, options = {})
        request_url = PaddlePay.config.vendors_url
        params = options.delete(:params) || {}
        headers = options.delete(:headers) || {}
        body = options.delete(:body) || {}

        conn = Faraday.new(url: request_url,
          proxy: proxy_url,
          ssl: {verify: PaddlePay.config.ssl_verify}) { |faraday|
          faraday.request :url_encoded
          faraday.response :raise_error
          faraday.response :json
          faraday.adapter :net_http
        }

        begin
          response = conn.post(url, config.merge(body)) { |req|
            req.params.merge!(params)
            req.headers.merge!(headers)
          }
          result = response.body

          unless result["success"]
            raise PaddlePayError.new(result["error"]["message"], result["error"]["code"])
          end

          PaddlePay::Util.convert_hash_keys(result["response"])
        rescue Faraday::ParsingError => e
          raise ParseError, "Invalid response object from API: #{e.response[:body]} " \
                    "(HTTP response code was #{e.response[:status]})"
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
        rescue Faraday::TimeoutError
          raise TimeoutError, "The connection has timed out"
        rescue Faraday::ConnectionFailed
          raise ConnectionError, "The connection failed"
        rescue Faraday::ServerError => e
          raise ServerError.new(e.response[:body], e.response[:status])
        end
      end

      private

      def config
        {
          vendor_id: PaddlePay.config.vendor_id,
          vendor_auth_code: PaddlePay.config.vendor_auth_code
        }
      end

      def proxy_url
        if PaddlePay.config.proxy_host && PaddlePay.config.proxy_port
          return "#{PaddlePay.config.proxy_host}:#{PaddlePay.config.proxy_port}"
        end

        nil
      end
    end
  end
end
