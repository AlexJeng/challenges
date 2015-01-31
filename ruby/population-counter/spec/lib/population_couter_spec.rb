require "spec_helper"
require "population_counter"

describe PopulationCounter do
  subject(:population_counter) { PopulationCounter.new }

  it "return the number of '1' bits set in the binary representation of that integer" do
    expect(population_counter.call(5)).to eq 2
    expect(population_counter.call(8)).to eq 1
    expect(population_counter.call(15)).to eq 4
    expect(population_counter.call(19)).to eq 3
  end
end