require 'pricing_rule'

module Rule
  class DropPrice < PricingRule
    def apply(basket)
      number_strawberries = count_product('Strawberries', basket)
      number_strawberries >= 3 ? number_strawberries * 0.50 : 0
    end
  end
end
