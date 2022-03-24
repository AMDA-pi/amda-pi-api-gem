# frozen_string_literal: true

module Amdapi
  class Error < StandardError; end

  class TokenError < StandardError
    def initialize(msg = "wrong credentials")
      super
    end
  end

  class ParamsError < StandardError
    def initialize(msg = "Malformed Params")
      super
    end
  end

  class CallNotFoundError < StandardError
    def initialize(msg = "Call not found")
      super
    end
  end
end
