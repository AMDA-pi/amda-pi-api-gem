# frozen_string_literal: true

require "faraday"
require "pry"

RSpec.describe Amdapi do
  it "should be able to access the call_uuid when getting a call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.get("/v1/calls/123456789") { [200, {}, call_get_stub] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    call = client.find("123456789")
    expect(call.call_uuid).to eq("123456789")
    expect(call.call_info["audio_duration"]).to eq(44.16)
    expect(call.call_info["total_speakers"]).to eq(2)
    expect(call.call_info["speakers_stats"]["agent"]["total_duration"]).to eq(16.119999999999994)
  end

  it "should return an error if trying to get non existing call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.get("/v1/calls/123456789") { [404, {}, {}] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    expect { client.find("123456789") }.to raise_error(Amdapi::CallNotFoundError)
  end

  it "should be able to access the calls uuid when getting all calls" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.get("/v1/calls") { [200, {}, calls_get_stub] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    calls = client.all
    expect(calls.data.count).to eq(2)
    expect(calls.data.first.call_uuid).to eq("e52438ec8c0a")
    expect(calls.data[1].call_uuid).to eq("123456789")
  end

  it "should be able to delete a call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.delete("/v1/calls/123456789") { [200, {}, { success: true, message: "call 123456789 deleted_sucessfully" }.to_json] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    response = client.delete("123456789")
    expect(response["success"]).to eq(true)
    expect(response["message"]).to eq("call 123456789 deleted_sucessfully")
  end

  it "should return an error if trying to delete non existing call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.delete("/v1/calls/123456789") { [404, {}, {}] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    expect { client.delete("123456789") }.to raise_error(Amdapi::CallNotFoundError)
  end

  it "should return the uuid of the new created call" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
      st.post("/amda-pi-storage") { [200, {}, call_post_stup] }
      st.put("https://fancy_url.com") { [200, {}, {}] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    call = client.analyze(params: call_create_stup, file: "a fancy file")
    expect(call.call_uuid).to eq(JSON.parse(call_post_stup)["data"]["call_uuid"])
  end

  it "should return an error if malformed params provided" do
    stub = Faraday::Adapter::Test::Stubs.new do |st|
      st.post("/oauth2/token") { [200, {}, { access_token: "blabla" }.to_json] }
    end

    client = Amdapi::Client.new(client_id: "test", client_secret: "test", adapter: :test, stubs: stub)
    expect { client.analyze(params: { foo: "bar" }, file: "a fancy file") }.to raise_error(Amdapi::ParamsError)
  end

  def call_get_stub
    File.read("spec/fixtures/call_get.json")
  end

  def calls_get_stub
    File.read("spec/fixtures/calls_get.json")
  end

  def call_create_stup
    {
      agent_id: 1,
      client_id: 2,
      customer_id: 3,
      origin: "Inbound",
      language: "en",
      call_id: "QHM53S8G4P",
      filename: "test_audio_nameQHM53S8G4P",
      company_name: "super_client"
    }
  end

  def call_post_stup
    File.read("spec/fixtures/call_post.json")
  end
end
