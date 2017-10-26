RSpec.describe 'palladius' do
  let(:converter) { Ting.from(:hanyu, :numbers).to(:palladius, :no_tones) }

  it 'should convert from Hanyu pinyin to Palladius' do
    expect(converter.call('you3 peng2 zi4 yuan2 fang2 lai2')).to eql 'ю пэн цзы юaнь фан лай'
  end

  it 'avoids the word for "penis"' do
    expect(converter.call('hui4')).to eql 'хуэй'
  end
end
