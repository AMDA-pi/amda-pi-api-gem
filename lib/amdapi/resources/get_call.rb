# frozen_string_literal: true

module Amdapi
  class GetCall < Resource
    attr_reader :call_uuid

    def initialize(call_uuid = "", token, adapter, stubs)
      @call_uuid = call_uuid
      super(token, adapter: adapter, stubs: stubs)
    end

    def find
      response = get_request(call_uuid, headers: headers)
      return nil if response.status == 404

      data = JSON.parse(response.body)["data"]
      Call.new data, call_uuid: data["call_uuid"], token: token
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
