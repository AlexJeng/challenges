require 'product'

describe Product do
  describe 'creating a new product' do
    context 'when product code is GR1' do
      before(:each) do
        @product = Product.new(:GR1)
      end

      it 'name should be Green tea' do
        @product.name.should eq 'Green tea'
      end

      it 'price should be 3.11' do
        @product.price.should eq 3.11
      end
    end

    context 'when product code is SR1' do
      before(:each) do
        @product = Product.new(:SR1)
      end

      it 'name should be Strawberries' do
        @product.name.should eq 'Strawberries'
      end

      it 'price should be 5.00' do
        @product.price.should eq 5.00
      end
    end

    context 'when product code is CF1' do
      before(:each) do
        @product = Product.new(:CF1)
      end

      it 'name should be Coffee' do
        @product.name.should eq 'Coffee'
      end

      it 'price should be 11.23' do
        @product.price.should eq 11.23
      end
    end
  end
end
