require 'pricing_rule'

module Rule
  class FreeItem < PricingRule
    def apply(basket)
      count_product('Green tea', basket) / 2 * 3.11
    end
  end
end
