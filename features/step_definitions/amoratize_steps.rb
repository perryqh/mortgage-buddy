def amoratizer
  @amoratizer ||= MortgageBuddy::Amoratizer.new(loan_amount:               @loan_amount,
                                                interest_rate:             @interest_rate,
                                                period:                    @period,
                                                interest_rounding_strategy: MortgageBuddy::FloorRounding,
                                                extra_monthly_payment:     @extra_monthly_payment)
end

Given(/^a loan amount of \$(\d+)$/) do |loan_amount|
  @loan_amount = loan_amount
end

Given(/^an interest rate of (.*)%$/) do |interest_rate|
  @interest_rate = interest_rate
end

Given(/^a period of (\d+)$/) do |period|
  @period = period
end

Given(/^an extra monthly payment of \$(.*)$/) do |extra_monthly_payment|
  @extra_monthly_payment = extra_monthly_payment
end

Then(/^the monthly payment should be \$(.*)$/) do |monthly_payment|
  expect(amoratizer.actual_monthly_payment.to_s).to eq(monthly_payment)
end

Then(/^the total interest paid should be \$(.*)$/) do |total_interest|
  expect(amoratizer.total_interest.to_s).to eq(total_interest)
end

Then(/^the number of payments should be (\d+)$/) do |total_num_payments|
  expect(amoratizer.total_num_payments.to_s).to eq(total_num_payments)
end