# 1. An empty string returns zero `'' => 0`
# 2. A single number returns the value `'1' => 1` `'2' => 2`
# 3. Two numbers, comma delimited, returns the sum `'1,2' => 3` `'10,20' => 30`
# 4. Two numbers, newline delimited, returns the sum `'1\n2' => 3`
# 5. Three numbers, delimited either way, returns the sum `'1\n2,3\n4' => 10`
# 6. Negative numbers throw an exception with the message `'-1,2,-3' => 'negatives not allowed: -1,-3'`
# 7. Numbers greater than 1000 are ignored
# 8. A single char delimiter can be defined on the first line starting with `//` (e.g `//#\n1#2` for a ‘#’ as the delimiter)
# 9. A multi char delimiter can be defined on the first line starting with `//` (e.g. `//###\n1###2` for ‘###’ as the delimiter)

# 10 Allow the string calculator to accept roman numerals
# 11 Allow the string calculator to return roman numerals

require './src/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  it 'should return 0 when given an empty string' do
    result = calculator.add('')

    expect(result).to eq(0)
  end

  it 'should return the number when given a single nimber' do
    result = calculator.add('1')

    expect(result).to eq(1)
  end

  it 'should return the sum when given 2 integers separated by a comma' do
    result = calculator.add('1,2')

    expect(result).to eq(3)
  end

  it 'should return the sum when given 2 numbers and a newline as delimiter' do
    result = calculator.add('1\n2')
    expect(result).to eq(3)
  end

  it 'should return the sum when numbers are delimited by comma and/or newline' do
    result = calculator.add('1\n2,3\n4')
    expect(result).to eq(10)
  end

  it 'should throw an exception when negative numbers are used' do
    expect {
      calculator.add('-1,2,-3')
    }.to raise_error('negatives not allowed: -1,-3')
  end

  it 'should ignore any numbers greater than 1000' do
    result = calculator.add('2,3,1001')
    expect(result).to eq(5)
  end

  it 'should use a custom delimiter' do
    result = calculator.add('//#\n1#2')
    expect(result).to eq(3)
  end

  it 'should use a complicated delimiter' do
    result = calculator.add('//###\n1###2')
    expect(result).to eq(3)
  end
end
