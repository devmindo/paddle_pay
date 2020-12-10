# frozen_string_literal: true

require "test_helper"

describe PaddlePay::Connection do
  before do
    @connection = PaddlePay::Connection
  end

  describe "when a request is made" do
    it "should return a json parsed response if request is successful" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(body: '{"success":true,"response":[{"data": "abcd"}]}', status: 200)
      response = @connection.request("")
      assert_instance_of Array, response
      assert_equal response.first[:data], "abcd"
    end

    it "should raise a paddle pay error if request is not successful" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(body: '{"success":false,"error":{"code":100,"message":"Error"}}', status: 200)
      assert_raises PaddlePay::PaddlePayError do
        @connection.request("")
      end
    end

    it "should raise a parse error if response is not in json format" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(body: "abcd", status: 200)
      assert_raises PaddlePay::ParseError do
        @connection.request("")
      end
    end

    it "should raise a bad request error if status 400 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [400, "Bad Request"])
      assert_raises PaddlePay::BadRequestError do
        @connection.request("")
      end
    end

    it "should raise an unauthorized error if status 401 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [401, "Unauthorized"])
      assert_raises PaddlePay::UnauthorizedError do
        @connection.request("")
      end
    end

    it "should raise a forbidden error if status 403 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [403, "Forbidden"])
      assert_raises PaddlePay::ForbiddenError do
        @connection.request("")
      end
    end

    it "should raise a resource not found error if status 404 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [404, "Not Found"])
      assert_raises PaddlePay::ResourceNotFoundError do
        @connection.request("")
      end
    end

    it "should raise a proxy authentication error if status 407 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [407, "Proxy Authentication Required"])
      assert_raises PaddlePay::ProxyAuthError do
        @connection.request("")
      end
    end

    it "should raise a conflict error if status 409 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [409, "Conflict"])
      assert_raises PaddlePay::ConflictError do
        @connection.request("")
      end
    end

    it "should raise an unprocessable entity error if status 422 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [422, "Unprocessable Entity"])
      assert_raises PaddlePay::UnprocessableEntityError do
        @connection.request("")
      end
    end

    it "should raise a connection error if connection failed" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_timeout
      assert_raises PaddlePay::ConnectionError do
        @connection.request("")
      end
    end

    it "should raise an timeout error if request timed out" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_raise(Net::ReadTimeout)
      assert_raises PaddlePay::TimeoutError do
        @connection.request("")
      end
    end

    it "should raise a server error if status 500 is returned" do
      stub_request(:post, PaddlePay.config.vendors_url)
        .to_return(status: [500, "Internal Server Error"])
      assert_raises PaddlePay::ServerError do
        @connection.request("")
      end
    end
  end
end
