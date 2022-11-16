require './src/roman_numeral'


RSpec.configure do |config|
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true
end

RSpec.describe RomanNumeral do
    describe "#to_integer" do
        context 'numeral element values' do
            {
                'I' => 1,
                'V' => 5,
                'X' => 10,
                'L' => 50,
                'C' => 100,
                'D' => 500,
                'M' => 1000,
            }.each do |input_numeral, expected_value|
                it "returns #{expected_value} for #{input_numeral}" do
                    int = to_i(input_numeral)
                
                    expect(int).to eq expected_value
                end
            end
        end

        context 'adding numeral elements' do
            it "returns 7 for VII" do
                int = to_i("VII")
    
                expect(int).to eq 7
            end
        end

        context 'subtractive behaviour' do
            it "returns 4 for IV" do
                int = to_i("IV")
    
                expect(int).to eq 4
            end
            it "returns 9 for IX" do
                int = to_i("IX")
    
                expect(int).to eq 9
            end
        end

        def to_i(numeral)
            roman_numeral = RomanNumeral.new

            roman_numeral.to_integer(numeral)
        end
    end

    describe '#to_roman' do
        it 'should return I when given 1' do
            converter = RomanNumeral.new
            
            result = converter.to_roman(1)

            expect(result).to eq('I')
        end

        it 'should return II when given 2' do
            converter = RomanNumeral.new
            
            result = converter.to_roman(2)

            expect(result).to eq('II')
        end
    end

    describe '#is_roman?' do
        it 'should return true when given I' do
            converter = RomanNumeral.new
            result = converter.is_roman?('I')
            expect(result).to eq(true)
        end

        it 'should return false when given 3' do
            converter = RomanNumeral.new
            result = converter.is_roman?('3')
            expect(result).to eq(false)
        end

        it 'should return true when given MXCII' do
            converter = RomanNumeral.new
            result = converter.is_roman?('MXCII')
            expect(result).to eq(true)
        end
    end
end
