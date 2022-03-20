# frozen_string_literal: true

module Amdapi
  class Resource
    BASE_URL = "https://api-amdapi.com"

    def initialize(token)
      @token = token
    end

    def get_request(call_uuid = nil, params: {}, headers: {})
      connection.get("v1/calls/#{call_uuid}", params, default_headers.merge(headers))
    end

    def post_call_request(params, headers: {})
      connection.post("amda-pi-storage", params.to_json, default_headers.merge(headers))
    end

    def post_audio_request(url, file, headers: {})
      connection.put(url, file, headers)
    end

    def delete_call(call_uuid, params: {}, headers: {})
      connection.delete("v1/calls/#{call_uuid}", params, default_headers.merge(headers))
    end

    private

    attr_reader :token

    def connection
      @connection ||= Faraday.new(url: BASE_URL)
    end

    def default_headers
      { "Authorization" => "Bearer #{token}" }
    end
  end
end
