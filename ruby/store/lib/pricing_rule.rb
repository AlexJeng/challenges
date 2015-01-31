module Rule
  class PricingRule
    def apply(basket)
    end

    private
    def count_product(name, basket)
      basket.inject(0) do |count, product|
        product.name == name ? count + 1 : count
      end
    end
  end
end
