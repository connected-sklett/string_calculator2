class StringCalculator
  attr_reader :str

  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')
    @str = str

    ensure_valid_ints.sum { |x| x.to_i }
  end

  private

  def ints
    @ints ||= Delimiter.create(str).split()
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
