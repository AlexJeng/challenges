class Product
  attr_reader :name
  attr_reader :price

  def initialize(code)
    case code
    when :GR1
      @name = 'Green tea'
      @price = 3.11
    when :SR1
      @name = 'Strawberries'
      @price = 5.00
    when :CF1
      @name = 'Coffee'
      @price = 11.23
    end
  end
end
