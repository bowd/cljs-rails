require 'spec_helper'

describe 'cljs_main_path' do
  include Cljs::Rails::Helper
  before(:each) do
    # Reset configuration
    ::Rails.configuration.cljs.main_target = "main"
    ::Rails.configuration.cljs.dev_server.port = 5555
    ::Rails.configuration.cljs.dev_server.host = 'localhost'
  end

  it "should use https protocol when https is true" do
    ::Rails.configuration.cljs.dev_server.https = true
    expect(cljs_main_path).to be_starts_with('https:')
  end

  it "should use http protocol when https is false" do
    ::Rails.configuration.cljs.dev_server.https = false
    expect(cljs_main_path).to be_starts_with('http:')
  end

  context "when in development" do
    before do
      allow(Rails.env).to receive :production? { false }
      allow(Rails.env).to receive :development? { true }
    end

    it "should have the user talk to the dev server" do
      ::Rails.configuration.cljs.dev_server.port = 4000
      ::Rails.configuration.cljs.dev_server.host = 'boot-dev-server.host'

      expect(cljs_main_path).to eq("http://boot-dev-server.host:4000/main.js")
    end
  end

  context "when in prouction" do
    before do
      allow(Rails.env).to receive :production? { true }
      allow(Rails.env).to receive :development? { false }
    end

    it "should have the user talk to the dev server" do
      ::Rails.configuration.cljs.dev_server.port = 4000
      ::Rails.configuration.cljs.dev_server.host = 'boot-dev-server.host'

      expect(cljs_main_path).to eq("main.js")
    end
  end

  it "should use the main target configuration if specified" do
    ::Rails.configuration.cljs.main_target = "apples"
    expect(cljs_main_path).to be_ends_with("apples.js")
  end
end
