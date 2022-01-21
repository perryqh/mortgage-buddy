# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MortgageBuddy::PaymentPlan do
  subject(:payment_plan) { described_class.new(params) }

  context 'a more complex example' do
    let(:params) do
      { loan_amount: 1000.0,
        interest_rounding_strategy: MortgageBuddy::FloorRounding,
        monthly_payment: 100.0,
        monthly_interest_rate: (5.0 / 100 / 12) }
    end

    context 'first payment' do
      subject { payment_plan.payments.first }

      its(:payment) { is_expected.to eq(100) }
      its(:number) { is_expected.to eq(1) }
      its(:principal) { is_expected.to eq(95.84) }
      its(:balance) { is_expected.to eq(904.16) }
      its(:interest) { is_expected.to eq(4.16) }
    end

    context 'middle payment' do
      subject { payment_plan.payments[6] }

      its(:payment) { is_expected.to eq(100) }
      its(:number) { is_expected.to eq(7) }
      its(:principal) { is_expected.to eq(98.26) }
      its(:balance) { is_expected.to eq(320.68) }
      its(:interest) { is_expected.to eq(1.74) }
    end

    context 'last payment' do
      subject { payment_plan.payments.last }

      its(:payment) { is_expected.to eq(23.53) }
      its(:number) { is_expected.to eq(11) }
      its(:principal) { is_expected.to eq(23.44) }
      its(:balance) { is_expected.to eq(0) }
      its(:interest) { is_expected.to eq(0.09) }
    end
  end

  context 'a simple example' do
    let(:params) do
      { loan_amount: 5.0,
        interest_rounding_strategy: MortgageBuddy::FloorRounding,
        monthly_payment: 2.0,
        monthly_interest_rate: (20.0 / 100 / 12) }
    end

    context 'first payment' do
      subject { payment_plan.payments.first }

      its(:payment) { is_expected.to eq(2.0) }
      its(:number) { is_expected.to eq(1) }
      its(:principal) { is_expected.to eq(1.92) }
      its(:balance) { is_expected.to eq(3.08) }
      its(:interest) { is_expected.to eq(0.08) }
    end

    context 'second payment' do
      subject { payment_plan.payments[1] }

      its(:payment) { is_expected.to eq(2.0) }
      its(:number) { is_expected.to eq(2) }
      its(:principal) { is_expected.to eq(1.95) }
      its(:balance) { is_expected.to eq(1.13) }
      its(:interest) { is_expected.to eq(0.05) }
    end

    context 'last payment' do
      subject { payment_plan.payments.last }

      its(:payment) { is_expected.to eq(1.14) }
      its(:number) { is_expected.to eq(3) }
      its(:principal) { is_expected.to eq(1.13) }
      its(:balance) { is_expected.to eq(0.0) }
      its(:interest) { is_expected.to eq(0.01) }
    end
  end
end
