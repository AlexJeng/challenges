module Currency
  module XBT
    class << self
      def name
        "Bitcoin"
      end

      def unit
        0.0001
      end
    end
  end

  module GBP
    class << self
      def name
        "Pound"
      end

      def unit
        0.01
      end
    end
  end
end
