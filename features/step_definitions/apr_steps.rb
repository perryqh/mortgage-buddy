Given /^(.*), (.*), (.*), (.*), (.*)$/ do |loan_amount, fees, points, rate, period|
  @mortgage_cost = MortgageBuddy::MortgageCost.new(loan_amount:   loan_amount,
                                                   interest_rate: rate,
                                                   period:        period,
                                                   fees:          fees,
                                                   points:        points)
end

Then /^the resultant apr should be (.*)$/ do |apr_expected|
  expect(@mortgage_cost.apr).to be_within(0.001).of(Float(apr_expected))
end
