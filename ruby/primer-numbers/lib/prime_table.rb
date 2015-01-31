require_relative "prime"

class PrimeTable
  def initialize(x, y)
    @top_row     = Prime.take x.to_i
    @left_column = Prime.take y.to_i
    @matrix = left_column.inject([]) do |matrix, multiplier|
      matrix << top_row.map { |value| multiplier * value }
    end
  end

  def call
    lines = [print_top_row, print_divider_row]
    left_column.each_with_index do |multiplier, row|
      lines << print_row(row)
    end
    lines.join("\n") << "\n"
  end

  private

  attr_reader :top_row, :left_column, :matrix

  def print_top_row
    @print_top_row ||= "".rjust(left_column_width) << " |#{print_content(top_row)}"
  end

  def print_divider_row
    print_top_row.gsub(/./, "-")
  end

  def print_content(content)
    string = ""
    content.each_with_index do |value, index|
      string += value.to_s.rjust(column_widths[index] + 1)
    end
    string
  end

  def print_row(row_number)
    "#{left_column[row_number].to_s.rjust(left_column_width)} |#{print_content(matrix[row_number])}"
  end

  def left_column_width
    @left_column_width ||= left_column.max.to_s.length
  end

  def column_widths
    @column_widths ||= matrix.transpose.map { |column| column.max.to_s.length }
  end
end
