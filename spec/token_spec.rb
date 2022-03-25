# frozen_string_literal: true

require "faraday"
require "pry"

RSpec.describe Amdapi do
  it "should have a token if given correct credentials" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    expect(client.token).to eq("blabla")
  end

  it "should throw an error if given the wrong credentials" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [400, {}, { error: "invalid_client" }.to_json] }
    end

    expect do
      Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    end.to raise_error(Amdapi::TokenError)
  end
end
