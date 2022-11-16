require './src/roman_numeral'

class StringCalculator
  attr_reader :str

  def add(str, lang = :decimal)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')
    @str = str

    sum = ensure_valid_ints.sum { |x| x.to_i }
    converter = RomanNumeral.new
    lang == :roman ? converter.to_roman(sum) : sum
  end

  private

  def ints
    converter = RomanNumeral.new
    @ints ||= Delimiter.create(str).split().map do |input|
      if converter.is_roman?(input)
        converter.to_integer(input)
      else
        input
      end
    end
  end

  def ensure_positive_integers
    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0
  end

  def ensure_less_than_1000
    ints.filter { |i| i.to_i <= 1000 }
  end

  def ensure_valid_ints
    ensure_positive_integers
    ensure_less_than_1000
  end
end

class Delimiter
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def split()
    str.split(/[\\n,]/)
  end

  def self.create(str)
    if str.include?('//')
      CustomDelimiter.new(str)
    else
      Delimiter.new(str)
    end
  end
end

class CustomDelimiter < Delimiter
  def split()
    head, tail = str.split('\n')
    delimiter = head.sub('//', '')
    tail.split(delimiter)
  end
end


# ---------------------

public interface Convertable {
  public int to_integer(input);
  public String to_string(input);
}

class RomanNumeralConverter implements Convertable {
  # ...
}

class DecimalConverter implements Convertable {
  # ....
}

def add(str, input_converter = DecimalConverter.new, output_converter = DecimalConverter.new)
  return 0 if str.empty?
  return str.to_i unless str.include?(',') || str.include?('\n')
  @str = str

  sum = ensure_valid_ints.sum { |x| x.to_i }
  output_converter.to_string(sum)
end

def ints
  converter = RomanNumeral.new
  @ints ||= Delimiter.create(str).split().map do |input|
    @input_converter.to_int(input)
  end
end
