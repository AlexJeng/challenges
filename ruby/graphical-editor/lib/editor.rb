require_relative 'image'

module GraphicalEditor
  class Editor
    REGEX_1_250_RANGE = '[1-9][0-9]?|1[0-9]{2}|2[0-4][0-9]|250'

    def execute(cmd)
      case cmd

      when /^I (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE})$/
        @image = Image.new($1.to_i, $2.to_i)

      when /^C$/
        @image.clear

      when /^L (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) ([A-Z])$/
        @image.colourize($1.to_i, $2.to_i, $3)

      when /^V (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) ([A-Z])$/
        @image.draw_vertical($1.to_i, $2.to_i, $3.to_i, $4)

      when /^H (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) ([A-Z])$/
        @image.draw_horizontal($1.to_i, $2.to_i, $3.to_i, $4)

      when /^F (#{REGEX_1_250_RANGE}) (#{REGEX_1_250_RANGE}) ([A-Z])$/
        @image.fill_region($1.to_i, $2.to_i, $3)

      when /^S$/
        puts @image

      when /^X$/
        exit

      else
        puts 'Unknown command'
      end
    end
  end
end
