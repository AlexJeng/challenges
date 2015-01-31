class DateRangeFormatter
  def initialize(start_on, end_on, starting_time = nil, ending_time = nil)
    @start_on = Date.parse(start_on)
    @end_on   = Date.parse(end_on)
    @starting_time, @ending_time = starting_time, ending_time
  end

  def to_s
    return format_date(same_day_different_month_different_year_starting_time_ending_time) if same_day? && !same_month? && !same_year? && starting_time && ending_time
    return format_date(same_day_different_month_different_year_starting_time)             if same_day? && !same_month? && !same_year? && starting_time
    return format_date(same_day_different_year)                                           if same_day? && !same_year?
    return format_date(same_day_different_month_same_year_starting_time_ending_time)      if same_day? && !same_month? && same_year? && starting_time && ending_time
    return format_date(same_day_different_month_same_year_starting_time)                  if same_day? && !same_month? && same_year? && starting_time
    return format_date(same_day_different_month_same_year)                                if same_day? && !same_month? && same_year?
    return format_date(different_day_same_month_starting_time_ending_time)                if !same_day? && same_month? && starting_time && ending_time
    return format_date(different_day_same_month_starting_time)                            if !same_day? && same_month? && starting_time
    return format_date(different_day_same_month)                                          if !same_day? && same_month?
    return format_date(full_date_starting_time_ending_time)                               if starting_time && ending_time
    return format_date(full_date_starting_time(start_on))                                 if starting_time
    return format_date(full_date(start_on))
  end

  private

  attr_reader :start_on, :end_on, :starting_time, :ending_time

  def format_date(closures)
    closures.flatten.inject([]) { |output, formatter| output << formatter.call }.join(" ")
  end

  def format_day(date)
    -> { date.day.ordinalize }
  end

  def format_month(date)
    -> { date.strftime("%B") }
  end

  def format_year(date)
    -> { date.strftime("%Y") }
  end

  def format_at_hour(time)
    -> { "at #{time}" }
  end

  def format_to_hour(time)
    -> { "to #{time}" }
  end

  def separator
    -> { "-" }
  end

  # 1st November 2009
  def full_date(date)
    [
      format_day(date),
      format_month(date),
      format_year(date),
    ]
  end

  # 1st November 2009 at 10:00
  def full_date_starting_time(date)
    [
      full_date(date),
      format_at_hour(starting_time),
    ]
  end

  # 1st November 2009 at 10:00 to 11:00
  def full_date_starting_time_ending_time
    [
      full_date_starting_time(start_on),
      format_to_hour(ending_time),
    ]
  end

  # 1st - 3rd November 2009
  def different_day_same_month
    [
      format_day(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 3rd November 2009
  def different_day_same_month_starting_time
    [
      full_date_starting_time(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 3rd November 2009 at 11:00
  def different_day_same_month_starting_time_ending_time
    [
      different_day_same_month_starting_time,
      format_at_hour(ending_time),
    ]
  end

  # 1st November - 1st December 2009
  def same_day_different_month_same_year
    [
      format_day(start_on),
      format_month(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 1st December 2009
  def same_day_different_month_same_year_starting_time
    [
      full_date_starting_time(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 1st December 2009 at 11:00
  def same_day_different_month_same_year_starting_time_ending_time
    [
      same_day_different_month_same_year_starting_time,
      format_at_hour(ending_time),
    ]
  end

  # 1st November 2009 - 1st December 2010
  def same_day_different_year
    [
      full_date(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 1st December 2010
  def same_day_different_month_different_year_starting_time
    [
      full_date_starting_time(start_on),
      separator,
      full_date(end_on),
    ]
  end

  # 1st November 2009 at 10:00 - 1st December 2010 at 11:00
  def same_day_different_month_different_year_starting_time_ending_time
    [
      same_day_different_month_different_year_starting_time,
      format_at_hour(ending_time),
    ]
  end

  def same_day?
    start_on.day == end_on.day
  end

  def same_month?
    start_on.month == end_on.month
  end

  def same_year?
    start_on.year == end_on.year
  end
end

class Fixnum
  def ordinalize
    if (11..13).include?(self.abs % 100)
      "#{self}th"
    else
      case self.to_i.abs % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end
