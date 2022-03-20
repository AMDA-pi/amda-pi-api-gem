# frozen_string_literal: true

module Amdapi
  class Collection
    attr_reader :data, :current_page, :next_page, :is_last_page

    def self.from_response(response, key: "calls", type: Call)
      new(
        data: response[key].map { |attrs| type.new(attrs) },
        current_page: response["current_page"],
        next_page: response["next_page"],
        is_last_page: response["is_last_page"]
      )
    end

    def initialize(data:, current_page:, next_page:, is_last_page:)
      @current_page = current_page
      @next_page = next_page
      @is_last_page = is_last_page
      @data = data
    end
  end
end
