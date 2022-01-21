# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MortgageBuddy::MortgageCost do
  let(:params) do
    { loan_amount: 100_000,
      interest_rate: 6.0,
      period: 360,
      fees: 1200,
      points: 1.25 }
  end
  subject(:mortgage_cost) { described_class.new(params) }

  describe 'initialize' do
    its(:loan_amount) { is_expected.to eq(params[:loan_amount]) }
    its(:interest_rate) { is_expected.to eq(params[:interest_rate]) }
    its(:period) { is_expected.to eq(params[:period]) }
    its(:fees) { is_expected.to eq(params[:fees]) }
    its(:points) { is_expected.to eq(params[:points]) }

    context 'without loan_amount' do
      before { params[:loan_amount] = nil }

      it 'raises error' do
        expect { mortgage_cost }.to raise_error('[:loan_amount] required')
      end
    end

    context 'without interest_rate' do
      before { params[:interest_rate] = nil }

      it 'raises error' do
        expect { mortgage_cost }.to raise_error('[:interest_rate] required')
      end
    end

    context 'params as strings' do
      subject { described_class.new(string_params) }
      let(:string_params) do
        { loan_amount: '100000',
          interest_rate: '6.0',
          period: '360',
          fees: '1200',
          points: '1.25' }
      end
      its(:loan_amount) { is_expected.to eq(params[:loan_amount]) }
      its(:interest_rate) { is_expected.to eq(params[:interest_rate]) }
      its(:period) { is_expected.to eq(params[:period]) }
      its(:fees) { is_expected.to eq(params[:fees]) }
      its(:points) { is_expected.to eq(params[:points]) }
    end
  end

  describe 'check calculations ' do
    def assert_monthly_apr_payment_matches(params)
      mortgage_cost             = described_class.new(params)
      monthly_payment_with_fees = mortgage_cost.monthly_payment_with_fees
      params[:interest_rate]    = mortgage_cost.apr
      params[:fees]             = 0
      params[:points]           = 0
      monthly_payment_from_apr  = described_class.new(params).monthly_payment
      expect(monthly_payment_with_fees).to eq(monthly_payment_from_apr)
    end

    describe 'the monthly payment with fees should be the same as the monthly payment with APR as interest rate' do
      [{ loan_amount: 300_000, interest_rate: 6.5, period: 360, fees: 1200, points: 1.25 },
       { loan_amount: 300_000, interest_rate: 6.5, period: 360, fees: 0, points: 0 },
       { loan_amount: 400_000, interest_rate: 1.1, period: 180, fees: 1200, points: 1.25 },
       { loan_amount: 300_000, interest_rate: 6.5, period: 360, fees: 0, points: 7.25 },
       { loan_amount: 300_000, interest_rate: 6.5, period: 360, fees: 10_000, points: 7.25 }].each do |test_hash|
        it 'checks that monthly payments match' do
          assert_monthly_apr_payment_matches test_hash
        end
      end
    end
  end

  context 'net negative fees' do
    let(:params) do
      { loan_amount: 100_000,
        interest_rate: 6.0,
        period: 360,
        fees: 1200,
        points: -11.25 }
    end
    its(:total_fees) { is_expected.to eq(0) }

    it 'calculates total fees' do
      expect(mortgage_cost.send(:calculate_total_fees)).to eq(-10_050.0)
    end

    it 'actual total fees' do
      expect(mortgage_cost.total_fees(true)).to eq(-10_050.0)
    end

    it 'does not return APR less than interest rate' do
      expect(mortgage_cost.apr).to be_within(0.00001).of(6.0)
    end
  end
end
