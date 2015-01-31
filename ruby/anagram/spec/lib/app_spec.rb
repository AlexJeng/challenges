require "app"
require "rack/test"

RSpec.describe App do
  include Rack::Test::Methods
  subject(:app) { App.new }

  context "find anagrams of a single word without results" do
    it "returns a empty list as JSON" do
      get "/sdfwehrtgegfg"
      expect(last_response.body).to eq({"sdfwehrtgegfg" => []}.to_json)
    end
  end

  context "find anagrams of a list of words" do
    it "returns a list of anagrams for each word as JSON" do
      get "/crepitus,paste"
      expect(last_response.body).to eq(
        {
          "crepitus" => ["crepitus", "cuprites", "pictures", "piecrust"],
          "paste"    => ["paste", "pates", "peats", "septa", "spate", "tapes", "tepas"],
        }.to_json
      )
    end
  end
end
