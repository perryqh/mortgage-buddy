module MortgageBuddy
  class Amoratizer
    include SafeNum, Monthly
    attr_reader :interest_rate, :loan_amount, :period
    attr_reader :extra_monthly_payment # optional

    # == Parameters
    # [:loan_amount]  Loan amount. Price of home minus down payment
    # [:interest_rate] The actual interest rate of the loan
    # [:period] Number of months of the loan. 30 yr is 360. 15 yr is 189
    # [:extra_monthly_payment] This is the extra monthly principal payment. Optional and defaults to 0
    def initialize(params={})
      @interest_rate         = safe_float params[:interest_rate]
      @loan_amount           = safe_float params[:loan_amount]
      @period                = safe_int params[:period]
      @extra_monthly_payment = safe_float(params.fetch(:extra_monthly_payment, 0))
    end

    def total_interest
      payments.inject(0){|sum,pay| sum + pay.interest }.round(2)
    end

    # A = [i * P * (1 + i)^n] / [(1 + i)^n - 1]
    # A = minimum_monthly_payment
    # P = loan amount
    # i = monthly interest rate
    # n = period (number of payments)
    def minimum_monthly_payment
      @minimum_monthly_payment ||= calculate_minimum_monthly_payment
    end

    def actual_monthly_payment
      (minimum_monthly_payment + @extra_monthly_payment).round(2)
    end

    def total_num_payments
      payments.length
    end

    def payments
      @payments ||= MortgageBuddy::PaymentPlan.build(loan_amount:           self.loan_amount,
                                                     monthly_payment:       actual_monthly_payment,
                                                     monthly_interest_rate: monthly_interest_rate)
    end

    private
    def calculate_minimum_monthly_payment
      period_rate = (1 + monthly_interest_rate)**(self.period)
      numerator   = monthly_interest_rate * self.loan_amount * period_rate
      denominator = period_rate - 1
      (numerator / denominator).round(2)
    end
  end
end