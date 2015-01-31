require "prime"

RSpec.describe Prime do
  describe ".take" do
    it "returns a list of prime numbers" do
      expect(Prime.take(10)).to eq([2, 3, 5, 7, 11, 13, 17, 19, 23, 29])
    end
  end
end
