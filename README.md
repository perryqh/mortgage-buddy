# MortgageBuddy
[![Gem Version](https://badge.fury.io/rb/mortgage-buddy.svg)](https://badge.fury.io/rb/mortgage-buddy)
[![Build Status](https://travis-ci.org/perryqh/mortgage-buddy.svg?branch=master)](https://travis-ci.org/perryqh/mortgage-buddy)

This gem will calculate APR and Amoratization.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mortgage-buddy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mortgage-buddy

## Usage
```ruby

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


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mortgage-buddy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

