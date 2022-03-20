require 'ostruct'

module Amdapi
  class Object
    def initialize(attr)
      @attributes = OpenStruct.new(attr)
    end

    def method_missing(method, *args, &block)
      attribute = @attributes.send(method, *args, &block)
      attribute.is_a?(Hash) ? Object.new(attribute) : attribute
    end

    def respond_to_missing?(method, include_private = false)
      true
    end
  end
end
