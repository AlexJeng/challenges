require "anagram"

RSpec.describe Anagram do
  subject(:anagram) { Anagram.new(:wordlist => wordlist) }

  context "find anagrams of a single word without results" do
    let(:wordlist) { [] }

    it "returns a empty list" do
      expect(anagram.call(%w(sdfwehrtgegfg))).to eq({"sdfwehrtgegfg" => []})
    end
  end

  context "find anagrams of a single word" do
    let(:wordlist) { %w(arturo crepitus cuprites herrero pictures piecrust test) }

    it "returns a list of anagrams" do
      expect(anagram.call(%w(crepitus))).to eq(
        {"crepitus" => ["crepitus", "cuprites", "pictures", "piecrust"]}
      )
    end
  end

  context "find anagrams of a list of words" do
    let(:wordlist) { %w(arturo crepitus cuprites herrero paste pates peats pictures piecrust septa spate tapes tepas test) }

    it "returns a list of anagrams for each word" do
      expect(anagram.call(%w(crepitus paste))).to eq(
        {
          "crepitus" => ["crepitus", "cuprites", "pictures", "piecrust"],
          "paste"    => ["paste", "pates", "peats", "septa", "spate", "tapes", "tepas"],
        }
      )
    end
  end
end
