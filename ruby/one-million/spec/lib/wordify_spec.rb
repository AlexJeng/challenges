require "spec_helper"
require "wordify"

describe Wordify do
  subject(:wordify) { Wordify.new }

  context "units" do
    it "returns a unit number in words" do
      expect(wordify.call(1)).to eq "one"
      expect(wordify.call(2)).to eq "two"
      expect(wordify.call(15)).to eq "fifteen"
    end
  end

  context "tens" do
    it "returns a ten number in words" do
      expect(wordify.call(10)).to eq "ten"
      expect(wordify.call(20)).to eq "twenty"
      expect(wordify.call(30)).to eq "thirty"
    end

    it "returns a ten number with unit in words" do
      expect(wordify.call(23)).to eq "twenty three"
      expect(wordify.call(42)).to eq "forty two"
    end
  end

  context "hundreds" do
    it "returns a hundred number in words" do
      expect(wordify.call(100)).to eq "one hundred"
    end

    it "returns a hundred number with ten and unit in words" do
      expect(wordify.call(101)).to eq "one hundred and one"
      expect(wordify.call(225)).to eq "two hundred and twenty five"
    end
  end

  context "thousands" do
    it "returns a thousand number in words" do
      expect(wordify.call(1000)).to eq "one thousand"
      expect(wordify.call(100_000)).to eq "one hundred thousand"
      expect(wordify.call(467_000)).to eq "four hundred and sixty seven thousand"
    end

    it "returns a thousand number with hundred, ten and unit in words" do
      expect(wordify.call(467_345)).to eq "four hundred and sixty seven thousand three hundred and forty five"
    end
  end

  context "million" do
    it "returns a million in words" do
      expect(wordify.call(1_000_000)).to eq "one million"
    end
  end

  context "invalid number" do
    it "returns an error message" do
      expect(wordify.call(0)).to eq "invalid number"
      expect(wordify.call(1_000_001)).to eq "invalid number"
      expect(wordify.call("invalid number")).to eq "invalid number"
    end
  end
end
