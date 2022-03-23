# frozen_string_literal: true
require "faraday"
require "pry"

RSpec.describe Amdapi do
  it "has a version number" do
    expect(Amdapi::VERSION).not_to be nil
  end
end
