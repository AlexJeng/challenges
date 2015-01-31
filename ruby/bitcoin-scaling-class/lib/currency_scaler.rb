require "securerandom"
require_relative "currency_logger"

class CurrencyScaler
  def initialize(args = {})
    @orders = args.fetch(:orders) { [] }
    @logger = args.fetch(:logger) { CurrencyLogger.new }
  end

  def place_order(args)
    save_order(
      order(args.merge(:method => "Place order"))
    )
  end

  def get_orders
    orders
  end

  def cancel_order(args)
    save_order(
      order(args.merge(:method => "Cancel order"))
    )
  end

  def watch_orders(watch)
    logger.verbosity = watch ? logger::VERBOSE : logger::NO_VERBOSE
  end

  def watch_ticker(watch)

  end

  private

  attr_reader :logger
  attr_accessor :orders

  def save_order(order)
    logger.log(order)

    id = order_id
    orders << { id => order }
    id
  end

  def order(args)
    "#{args[:method]} for #{quantity(args)} at a unit price of #{price(args)}"
  end

  def quantity(args)
    "#{args[:quantity] * args[:base].unit} #{args[:base].name}"
  end

  def price(args)
    "#{scale(args[:price]) * args[:counter].unit} #{args[:counter].name}"
  end

  def scale(price)
    price / 10000
  end

  def order_id
    SecureRandom.uuid
  end
end
