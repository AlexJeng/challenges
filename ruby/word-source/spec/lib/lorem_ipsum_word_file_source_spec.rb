require "spec_helper"
require "lorem_ipsum_word_file_source"

describe LoremIpsumWordFileSource do
  subject(:src) {
    LoremIpsumWordFileSource.new(
      :path => expand_path("../../support/lorem_ipsum.txt"),
    )
  }

  it "returns the next word from the source" do
    expect(src.next_word).to eq "lorem"
    expect(src.next_word).to eq "ipsum"
    expect(src.next_word).to eq "ipsum"
  end

  private

  def expand_path(path)
    File.expand_path(path, __FILE__)
  end
end
