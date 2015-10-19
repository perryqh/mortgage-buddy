require 'spec_helper'

describe MortgageBuddy::SafeNum do
  class DummySafeNum
    extend MortgageBuddy::SafeNum
  end

  describe '#safe_float' do
    let(:result) { DummySafeNum.safe_float(the_float) }

    context 'with float' do
      let(:the_float) { 12.2 }
      it 'returns the same float' do
        expect(result).to eq(the_float)
      end
    end

    context 'with string' do
      let(:the_float) { '9.2' }
      it 'converts to float' do
        expect(result).to eq(9.2)
      end
    end

    context 'not a number' do
      let(:the_float) { 'abra' }
      it 'raises error' do
        expect { result }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#safe_int' do
    let(:result) { DummySafeNum.safe_float(the_int) }

    context 'with int' do
      let(:the_int) { 121 }
      it 'returns the same int' do
        expect(result).to eq(the_int)
      end
    end

    context 'with string' do
      let(:the_int) { '92' }
      it 'converts to int' do
        expect(result).to eq(92)
      end
    end

    context 'not a number' do
      let(:the_int) { 'abra' }
      it 'raises error' do
        expect { result }.to raise_error(ArgumentError)
      end
    end
  end
end