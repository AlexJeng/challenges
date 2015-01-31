class PopulationCounter
  def call(number)
    number.to_s(2).count("1")
  end
end