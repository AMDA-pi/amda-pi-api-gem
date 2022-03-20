# frozen_string_literal: true

require_relative "amdapi/version"

module Amdapi
  autoload :Client, "amdapi/client"
  autoload :Error, "amdapi/error"

  autoload :Collection, "amdapi/collection"
  autoload :Object, "amdapi/object"
  autoload :Call, "amdapi/objects/call"
  autoload :Resource, "amdapi/resource"
  autoload :GetCall, "amdapi/resources/get_call"
  autoload :PostCall, "amdapi/resources/post_call"
  autoload :DeleteCall, "amdapi/resources/delete_call"
end
