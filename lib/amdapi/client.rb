# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "base64"
require "json"

module Amdapi
  class Client
    BASE_URL = "https://auth.api-amdapi.com"
    attr_reader :client_id, :client_secret, :token

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
      @token = generate_token
    end

    def generate_new_token
      @token = generate_token
    end

    def inspect
      "#<Amdapi::Client>"
    end

    def find(call_uuid)
      GetCall.new(call_uuid, token).find
    end

    def all(params: {})
      GetCall.new(token).all(params)
    end

    def create(params:, file:)
      PostCall.new(token, params, file).create
    end

    def delete(call_uuid)
      DeleteCall.new(token, call_uuid).delete
    end

    private

    def generate_token
      response = connection.post("/oauth2/token")
      JSON.parse(response.body)["access_token"]
    end

    def connection
      @connection ||= Faraday.new(
        url: BASE_URL,
        headers: headers,
        params: { grant_type: "client_credentials" }
      )
    end

    def headers
      string = "#{client_id}:#{client_secret}"
      base64_encoded = Base64.encode64(string)
      { "Authorization" => "Basic #{base64_encoded}".gsub("\n", ""), "Content-Type": "application/x-www-form-urlencoded" }
    end
  end
end
