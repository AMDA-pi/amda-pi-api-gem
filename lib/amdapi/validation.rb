module Amdapi
  class ParamsValidator
    def initialize(params)
      @params = params
    end

    def valid?
      params_keys.all? { |key| params[key] }
    end

    private

    attr_reader :params

    def params_keys
      %i[agent_id
         client_id
         customer_id
         origin
         language
         call_id
         filename
         company_name]
    end
  end
end
