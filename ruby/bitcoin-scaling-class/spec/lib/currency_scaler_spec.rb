require "spec_helper"
require "currency"
require "currency_scaler"

describe CurrencyScaler do
  let(:logger)     { double(:currency_logger, :log => nil) }
  subject(:scaler) { CurrencyScaler.new(:logger => logger) }

  let(:args) {
    {
      :quantity => 2000000,
      :price    => 1234560000,
      :base     => Currency::XBT,
      :counter  => Currency::GBP,
    }
  }

  let(:place_order) {
    "Place order for 200.0 Bitcoin at a unit price of 1234.56 Pound"
  }

  let(:cancel_order) {
    "Cancel order for 200.0 Bitcoin at a unit price of 1234.56 Pound"
  }

  it "places an order" do
    id = scaler.place_order(args)
    expect(scaler.get_orders).to eq [id => place_order]
  end

  it "cancels an order" do
    id = scaler.cancel_order(args)
    expect(scaler.get_orders).to eq [id => cancel_order]
  end

  it "gets all orders" do
    id_order_1 = scaler.place_order(args)
    id_order_2 = scaler.cancel_order(args)
    id_order_3 = scaler.place_order(args)

    expect(scaler.get_orders).to eq ([
      {id_order_1 => place_order},
      {id_order_2 => cancel_order},
      {id_order_3 => place_order},
    ])
  end
end
