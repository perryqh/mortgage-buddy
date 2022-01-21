# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MortgageBuddy::SafeNum do
  subject(:safe_num) do
    Class.new { extend MortgageBuddy::SafeNum }
  end

  describe '#safe_float' do
    subject(:safe_float) { safe_num.safe_float(the_float) }

    context 'with float' do
      let(:the_float) { 12.2 }
      it 'returns the same float' do
        expect(safe_float).to eq(the_float)
      end
    end

    context 'with string' do
      let(:the_float) { '9.2' }
      it 'converts to float' do
        expect(safe_float).to eq(9.2)
      end
    end

    context 'not a number' do
      let(:the_float) { 'abra' }
      it 'raises error' do
        expect { safe_float }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#safe_int' do
    subject(:safe_int) { safe_num.safe_int(the_int) }

    context 'with int' do
      let(:the_int) { 121 }
      it 'returns the same int' do
        expect(safe_int).to eq(the_int)
      end
    end

    context 'with string' do
      let(:the_int) { '92' }
      it 'converts to int' do
        expect(safe_int).to eq(92)
      end
    end

    context 'not a number' do
      let(:the_int) { 'abra' }
      it 'raises error' do
        expect { safe_int }.to raise_error(ArgumentError)
      end
    end
  end
end
