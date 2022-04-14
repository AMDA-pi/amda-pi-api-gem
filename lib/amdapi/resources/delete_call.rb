# frozen_string_literal: true

module Amdapi
  class DeleteCall < Resource
    attr_reader :call_uuid

    def initialize(token, call_uuid, adapter, stubs)
      super(token, adapter: adapter, stubs: stubs)
      @call_uuid = call_uuid
    end

    def delete
      response = delete_call(call_uuid, headers: headers)
      raise CallNotFoundError if response.status == 404

      JSON.parse(response.body)["success"]
    end

    private

    def headers
      { "Content-Type": "application/json" }
    end
  end
end
