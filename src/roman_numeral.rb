class RomanNumeral
    NUMERAL_TO_INTEGER = {
        'I' => 1,
        'V' => 5,
        'X' => 10,
        'L' => 50,
        'C' => 100,
        'D' => 500,
        'M' => 1000,
    }

    SUBTRACTIVE_PAIR_TO_INTEGER = {
        'IV' => 4,
        'IX' => 9,
        'XL' => 40,
        'XC' => 90,
        'CD' => 400,
        'CM' => 900,
    }

    def to_integer(roman_numeral)
        total_so_far, remaining_numerals_to_process = process_subtractive_pairs(roman_numeral)

        total_so_far + process_additive_numerals(remaining_numerals_to_process)
    end

    def to_roman(num)
        values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        roman_literals = %w[M CM D CD C XC L XL X IX V IV I]
    
        result = ''
        values.each_with_index do |val, i|
          while num >= val
            num -= val
            result = "#{result}#{roman_literals[i]}"
          end
        end
    
        result
    end

    def is_roman?(str)
        str.split('').all? { |n| !!NUMERAL_TO_INTEGER[n] }
    end

    private

    def process_subtractive_pairs(roman_numeral)
        roman_numeral_for_processing = roman_numeral.dup

        total_so_far = SUBTRACTIVE_PAIR_TO_INTEGER.reduce(0) do |total_value, (pair, value)|
            contains = roman_numeral_for_processing.slice!(pair)

            contains ? value + total_value : total_value
        end

        [total_so_far, roman_numeral_for_processing]
    end

    def process_additive_numerals(roman_numeral_for_processing)
        NUMERAL_TO_INTEGER.sum do |numeral, value|
            roman_numeral_for_processing.count(numeral) * value
        end
    end
end
