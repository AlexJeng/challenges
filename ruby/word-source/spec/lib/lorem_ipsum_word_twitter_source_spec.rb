require "spec_helper"
require "lorem_ipsum_word_twitter_source"

describe LoremIpsumWordTwitterSource, :vcr => { :cassette_name => "twitter_client" } do
  subject(:src) {
    LoremIpsumWordTwitterSource.new(
      :username => "arturoherrero",
    )
  }

  it "returns the next word from the source" do
    expect(src.next_word).to eq "Most"
    expect(src.next_word).to eq "overestimate"
    expect(src.next_word).to eq "people"
  end
end
