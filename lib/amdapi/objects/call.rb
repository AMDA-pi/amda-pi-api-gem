module Amdapi
  class Call < Object
    attr_reader :call_uuid

    def initialize(attr = {}, call_uuid: "")
      super(attr)
      @call_uuid = call_uuid
    end
  end
end
