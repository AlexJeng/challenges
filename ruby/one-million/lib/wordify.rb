class Wordify
  def initialize
    @units = %w{
      zero one two three four five six seven eight nine ten
      eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen
    }

    @tens = %w{ zero ten twenty thirty forty fifty sixty seventy eighty ninety }
  end

  def call(number)
    case number
    when 1..19          then unit(number)
    when 20..99         then ten(number)
    when 100..999       then hundred(number)
    when 1_000..999_999 then thousand(number)
    when 1_000_000      then million(number)
    else error_message
    end
  end

  private

  attr_reader :units, :tens

  def unit(number)
    units.fetch(number)
  end

  def ten(number)
    tens.fetch(number / 10) + add_unit(number)
  end

  def hundred(number)
    "#{call(number / 100)} hundred" + add_ten(number)
  end

  def thousand(number)
    "#{call(number / 1_000)} thousand" + add_hundred(number)
  end

  def million(number)
    "#{call(number / 1_000_000)} million"
  end

  def error_message
    "invalid number"
  end

  def add_unit(number)
    round_tent?(number)? "" : " #{call(number % 10)}"
  end

  def add_ten(number)
    round_hundred?(number)? "" : " and #{call(number % 100)}"
  end

  def add_hundred(number)
    round_thousand?(number)? "" : " #{call(number % 1000)}"
  end

  def round_tent?(number)
    number % 10 == 0
  end

  def round_hundred?(number)
    number % 100 == 0
  end

  def round_thousand?(number)
    number % 1000 == 0
  end
end
