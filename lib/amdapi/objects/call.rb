# frozen_string_literal: true

module Amdapi
  class Call
    attr_reader :call_uuid, :client_id, :agent_id, :customer_id, :call_info

    def initialize(attr = {}, call_uuid: "", token: "")
      @call_uuid = call_uuid
      @token = token
      @client_id = attr["client_id"]
      @agent_id = attr["agent_id"]
      @customer_id = attr["customer_id"]
      @call_info = attr["call_info"]
    end

    def inspect
      "#<Amdapi::Client call_uuid=#{call_uuid} client_id=#{client_id || client_id.inspect} " \
      "agent_id=#{agent_id || agent_id.inspect} " \
      "customer_id=#{customer_id || customer_id.inspect}>"
    end
  end
end
