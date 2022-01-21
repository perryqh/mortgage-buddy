# frozen_string_literal: true

module MortgageBuddy
  class AprCalculator
    attr_accessor :loan_amount, :monthly_payment_with_fees, :period, :monthly_interest_rate

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    # solves APR
    # [a (1 + a)^N] / [(1 + a)^N - 1] - P/C = 0
    # where a = APR/1200, N = period, P = monthly payment, C = loan_amount
    # calculate APR uses the Newton-Raphson to find the root (the value for 'a' that makes f(a) = 0)
    def apr
      payment_ratio = monthly_payment_with_fees / loan_amount
      f             = ->(k) { (k**(period + 1) - (k**period * (payment_ratio + 1)) + payment_ratio) }
      f_deriv       = lambda { |k|
        ((period + 1) * k**period) - (period * (payment_ratio + 1) * k**(period - 1))
      }

      root = newton_raphson(f, f_deriv, monthly_interest_rate + 1)
      100 * 12 * (root - 1).to_f
    end

    # if 'start' is the monthly_interest_rate, Newton Raphson will find the apr root very quickly
    # k1 = k0 - f(k0)/f'(k0)
    # k_plus_one = k - f(k)/f_deriv(k)
    # We find the k-intercept of the tangent line at point k_plus_one and compare k to k_plus_one.
    # This is repeated until a sufficiently accurate value is reached, which can be specified with the 'precision' parameter
    def newton_raphson(f, f_deriv, start, precision = 5)
      k_plus_one = start
      k          = 0.0

      while ((k - 1) * 10**precision).to_f.floor != ((k_plus_one - 1) * 10**precision).to_f.floor
        k          = k_plus_one
        k_plus_one = k - f.call(k) / f_deriv.call(k)
      end
      k_plus_one
    end
  end
end
