# frozen_string_literal: true

module Amdapi
  class PostCall < Resource
    attr_reader :params, :file

    def initialize(token, params, file)
      super(token)
      @params = params
      @file = file
    end

    def create
      url = JSON.parse(post_call_request(params, headers: call_headers).body)["data"]["url"]
      post_audio_request(url, file, headers: audio_headers)
    end

    private

    def call_headers
      { "Content-Type": "application/json" }
    end

    def audio_headers
      { "Content-Type": "audio/wav", "x-amz-acl": "public-read" }
    end
  end
end
