# frozen_string_literal: true

module Amdapi
  class Call < Object
    attr_reader :call_uuid

    def initialize(attr = {}, call_uuid: "", token: "")
      super(attr)
      @call_uuid = call_uuid
      @token = token
    end

    def refetch
      response = GetCall.new(call_uuid, @token).find
      @attributes = OpenStruct.new(response)
      true
    end
  end
end
