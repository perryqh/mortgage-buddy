require 'spec_helper'

describe MortgageBuddy::Amoratizer do
  let(:params) do
    {interest_rate: 5.0,
     loan_amount:   250000,
     period:        360}
  end
  subject { described_class.new(params) }
  its(:total_num_payments) { is_expected.to eq(360) }
  its(:minimum_monthly_payment) { is_expected.to eq(1342.05) }
  its(:actual_monthly_payment) { is_expected.to eq(1342.05) }
  its(:total_interest) { is_expected.to eq(233137.1) }

  context 'a bigger loan' do
    let(:params) do
      {interest_rate: 3.0,
       loan_amount:   550000,
       period:        360}
    end
    its(:total_num_payments) { is_expected.to eq(360) }
    its(:minimum_monthly_payment) { is_expected.to eq(2318.82) }
    its(:actual_monthly_payment) { is_expected.to eq(2318.82) }
    its(:total_interest) { is_expected.to eq(284773.56) }
  end

  context 'increase the payment' do
    let(:params) do
      {interest_rate:         3.0,
       loan_amount:           550000,
       period:                360,
       extra_monthly_payment: 4000}
    end
    its(:total_num_payments) { is_expected.to eq(99) }
    its(:minimum_monthly_payment) { is_expected.to eq(2318.82) }
    its(:actual_monthly_payment) { is_expected.to eq(6318.82) }
    its(:total_interest) { is_expected.to eq(71016.65) }
  end
end