require 'checkout'

describe Checkout do
  context "when there aren't promotional rules" do
    before(:each) do
      @checkout = Checkout.new([])
      @checkout.scan(:GR1)
      @checkout.scan(:SR1)
    end

    it 'can scan products' do
      @checkout.basket.length.should eq 2
    end

    it 'can sum product prices' do
      @checkout.total.should eq 8.11
    end
  end

  describe 'checkout system' do
    before(:each) do
      pricing_rules = [
        Rule::FreeItem.new,
        Rule::DropPrice.new
      ]
      @checkout = Checkout.new(pricing_rules)
    end

    context 'when basket is GR1,SR1,GR1,GR1,CF1' do
      it 'should return a total price 22.45' do
        @checkout.scan(:GR1)
        @checkout.scan(:SR1)
        @checkout.scan(:GR1)
        @checkout.scan(:GR1)
        @checkout.scan(:CF1)
        @checkout.total.should eq 22.45
      end
    end

    context 'when basket is GR1,GR1' do
      it 'should return a total price 3.11' do
        @checkout.scan(:GR1)
        @checkout.scan(:GR1)
        @checkout.total.should eq 3.11
      end
    end

    context 'when basket is SR1,SR1,GR1,SR1' do
      it 'should return a total price 16.61' do
        @checkout.scan(:SR1)
        @checkout.scan(:SR1)
        @checkout.scan(:GR1)
        @checkout.scan(:SR1)
        @checkout.total.should eq 16.61
      end
    end
  end
end
