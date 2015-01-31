class Checkout
  attr_reader :basket

  def initialize(pricing_rules)
    @basket = Array.new
    @pricing_rules = pricing_rules
  end

  def scan(product_code)
    @basket << Product.new(product_code)
  end

  def total
    total = @basket.inject(0) { |total, product| total + product.price }
    discount = @pricing_rules.inject(0) { |discount, rule| discount + rule.apply(@basket) }
    total - discount
  end
end
