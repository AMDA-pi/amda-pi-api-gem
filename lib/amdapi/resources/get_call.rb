# frozen_string_literal: true

module Amdapi
  class GetCall < Resource
    attr_reader :call_uuid

    def initialize(call_uuid = "", token)
      @call_uuid = call_uuid
      super(token)
    end

    def find
      Call.new JSON.parse(get_request(call_uuid, headers: headers).body)["data"]
    end

    def all(params = {})
      Collection.from_response JSON.parse(get_request(params: params, headers: headers).body)["data"]
    end

    private

    def headers
      { "Content-Type": "application/json" }
    end
  end
end
