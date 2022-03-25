# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "base64"
require "json"

module Amdapi
  class Client
    BASE_URL = "https://auth.api-amdapi.com"
    attr_reader :client_id, :client_secret, :token, :adapter

    def initialize(client_id:, client_secret:, adapter: Faraday.default_adapter, stubs: nil)
      @client_id = client_id
      @client_secret = client_secret
      @adapter = adapter
      @stubs = stubs
      @token = generate_token
    end

    def generate_new_token
      @token = generate_token
    end

    def inspect
      "#<Amdapi::Client>"
    end

    def find(call_uuid)
      GetCall.new(call_uuid, token, adapter, @stubs).find
    end

    def all(params: {})
      GetCall.new(token, adapter, @stubs).all(params)
    end

    def analize(params:, file:)
      raise ParamsError unless ParamsValidator.new(params).valid?

      PostCall.new(token, params, file, adapter, @stubs).create
    end

    def delete(call_uuid)
      DeleteCall.new(token, call_uuid, adapter, @stubs).delete
    end

    private

    def generate_token
      response = connection.post("/oauth2/token") do |req|
        req.headers = headers
        req.params["grant_type"] = "client_credentials"
      end
      token = JSON.parse(response.body)["access_token"]
      raise TokenError if token.nil?

      token
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.adapter adapter, @stubs
      end
    end

    def headers
      string = "#{client_id}:#{client_secret}"
      base64_encoded = Base64.encode64(string)
      { "Authorization" => "Basic #{base64_encoded}".gsub("\n", ""), "Content-Type": "application/x-www-form-urlencoded" }
    end
  end
end
