class CurrencyLogger
  VERBOSE    = true
  NO_VERBOSE = false

  def initialize(args = {})
    @output    = args.fetch(:output)    { STDOUT }
    @verbosity = args.fetch(:verbosity) { VERBOSE }
  end

  attr_writer :verbosity

  def log(msg)
    output.puts("[#{Time.now}] - #{msg}") if verbosity
  end

  private

  attr_reader :output, :verbosity
end
