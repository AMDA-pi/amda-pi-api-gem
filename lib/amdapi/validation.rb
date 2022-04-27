module Amdapi
  class ParamsValidator
    def initialize(params)
      @params = params
    end

    def valid?
      symbolize_keys
      params_keys.all? { |key| params[key] }
    end

    private

    attr_reader :params

    def symbolize_keys
      params.keys.each do |key|
        params[(key.to_sym rescue key) || key] = params.delete(key)
      end
    end

    def params_keys
      %i[agent_id
         client_id
         customer_id
         origin
         language
         call_id
         filename]
    end
  end
end
