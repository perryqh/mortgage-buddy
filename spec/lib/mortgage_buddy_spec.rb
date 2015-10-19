require 'spec_helper'

describe MortgageBuddy do
  it 'has a version number' do
    expect(MortgageBuddy::VERSION).not_to be nil
  end
end


loan_amount   = 550000
interest_rate = 3.0
period        = 360 # 12 months * 30 years
fees          = 600 # $600 closing costs
points        = 0 # no points to get this loan

mortgage_cost = MortgageBuddy::MortgageCost.new(loan_amount:   loan_amount,
                                                interest_rate: interest_rate,
                                                period:        period,
                                                fees:          fees,
                                                points:        points)
puts mortgage_cost.apr # 3.01% (rounded)
puts mortgage_cost.monthly_payment_with_fees # $2321.35 (rounded)

amoratizer_30_year = MortgageBuddy::Amoratizer.new(interest_rate: interest_rate,
                                           loan_amount:   loan_amount,
                                           period:        period)

puts amoratizer_30_year.total_num_payments # 360 or 30 years (no extra payment)
puts amoratizer_30_year.total_interest # $284,773.56 (disturbing)
puts amoratizer_30_year.payments # an array of openstructs with every payment amount, interest, principal, etc

# Now let's see what happens when we pay extra
amoratizer_with_pay_extra = MortgageBuddy::Amoratizer.new(interest_rate:         interest_rate,
                                                      loan_amount:           loan_amount,
                                                      period:                period,
                                                      extra_monthly_payment: 1000)

puts amoratizer_with_pay_extra.total_num_payments # 215 or just under 18 years
puts amoratizer_with_pay_extra.total_interest # $161053.35
puts amoratizer_30_year.total_interest - amoratizer_with_pay_extra.total_interest # a savings of $123720.21

# What if we can get a little bit lower rate on a 15 year?
amoratizer_15_year = MortgageBuddy::Amoratizer.new(interest_rate:         2.9,
                                                        loan_amount:           loan_amount,
                                                        period:                180,
                                                        extra_monthly_payment: 0)
puts amoratizer_15_year.total_num_payments # 180 15 years
puts amoratizer_15_year.total_interest # $128,923.59
puts amoratizer_15_year.actual_monthly_payment # $3771.80
puts amoratizer_30_year.total_interest - amoratizer_15_year.total_interest # a savings of $155,849.97
