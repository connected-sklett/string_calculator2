
class StringCalculator

  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    ints = getNumbers(str).split(str)

    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0

    ints.filter { |i| i.to_i <= 1000 }.sum { |x| x.to_i }
  end

  def getNumbers(str)
    if str.include?('//')
      CustomDelimiter.new
    else
      DefaultDelimier.new
    end
  end

  class CustomDelimiter
    def split(str)
      head, tail = str.split('\n')
      delimiter = head.sub('//', '')
      tail.split(delimiter)
    end
  end

  class DefaultDelimier
    def split(str)
      str.split(/[\\n,]/)
    end
  end
end
