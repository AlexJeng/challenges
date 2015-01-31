class Cron
  def initialize(args)
    @current_hour   = args.fetch(:current_hour)
    @current_minute = args.fetch(:current_minute)
    @config = args.fetch(:config)
  end

  def call
    config.each_line { |line|
      minute_config, hour_config, command_config = line.split(" ")

      new_hour   = calculate_new_hour(hour_config)
      new_minute = calculate_new_minute(minute_config, new_hour)
      day = calculate_day(new_hour, new_minute)
      puts "#{new_hour}:#{new_minute} #{day} - #{command_config}"
    }
  end

  private

  def calculate_new_hour(hour_config)
    if hour_config == "*"
      current_hour
    else
      hour_config
    end
  end

  def calculate_new_minute(minute_config, new_hour)
    if minute_config == "*"
      if new_hour != current_hour
        "00"
      else
        current_minute
      end
    else
      minute_config
    end
  end

  def calculate_day(new_hour, new_minute)
    if new_hour.to_i < current_hour.to_i
      "tomorrow"
    else
      if new_hour.to_i == current_hour.to_i
        if new_minute.to_i < current_minute.to_i
          "tomorrow"
        else
          "today"
        end
      else
        "today"
      end
    end
  end

  attr_reader :current_hour, :current_minute, :config
end
