# frozen_string_literal: true

module Amdapi
  class DeleteCall < Resource
    attr_reader :call_uuid

    def initialize(token, call_uuid)
      super(token)
      @call_uuid = call_uuid
    end

    def delete
      JSON.parse(delete_call(call_uuid, headers: headers).body)
    end

    private

    def headers
      { "Content-Type": "application/json" }
    end
  end
end
