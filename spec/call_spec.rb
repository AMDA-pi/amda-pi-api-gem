# frozen_string_literal: true

require "faraday"
require "pry"

RSpec.describe Amdapi do
  it "should be able to access the call_uuid when getting a call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.get("/v1/calls/123456789") { [200, {}, { data: { call_uuid: "123456789" } }.to_json] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    call = client.find("123456789")
    expect(call.call_uuid).to eq("123456789")
  end
end
