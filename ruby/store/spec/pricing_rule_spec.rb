require 'checkout'
require 'free_item'
require 'drop_price'

describe Rule::PricingRule do
  describe 'apply a pricing rule' do
    before(:each) do
      @checkout = Checkout.new([])
      @free_item = Rule::FreeItem.new
      @drop_price = Rule::DropPrice.new
    end

    context 'when buying green tea with free item rule' do
      it "shouldn't apply a discount with one green tea" do
        @checkout.scan(:GR1)
        @free_item.apply(@checkout.basket).should eq 0
      end

      it 'should apply a discount for one green tea and get one free' do
        @checkout.scan(:GR1)
        @checkout.scan(:GR1)
        @checkout.scan(:GR1)
        @checkout.scan(:GR1)
        @free_item.apply(@checkout.basket).should eq 6.22
      end
    end

    context 'when buying strawberries with drop price rule' do
      it "shouldn't apply a discount with less than three strawberries" do
        @checkout.scan(:SR1)
        @checkout.scan(:SR1)
        @drop_price.apply(@checkout.basket).should eq 0
      end

      it 'should apply a discount with three or more strawberries' do
        @checkout.scan(:SR1)
        @checkout.scan(:SR1)
        @checkout.scan(:SR1)
        @drop_price.apply(@checkout.basket).should eq 1.50
      end
    end
  end
end
