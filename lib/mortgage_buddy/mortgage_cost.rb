module MortgageBuddy
  class MortgageCost
    include MortgageBuddy::SafeNum, MortgageBuddy::Monthly
    attr_reader :loan_amount, :interest_rate, :period, :fees, :points
    DEFAULT_PERIOD = 360
    DEFAULT_FEES   = 0
    DEFAULT_POINTS = 0

    # == Parameters
    # [:loan_amount]  Loan amount. Price of home minus down payment
    # [:interest_rate] The interest rate of the loan
    # [:period] Number of months of the loan. 30 yr is 360. 15 yr is 189
    # [:fees] Closing cost fees. Optional and defaults to 0
    # [:points] Points. Optional and defaults to 0
    def initialize(params={})
      raise '[:loan_amount] required' if params[:loan_amount].blank?
      raise '[:interest_rate] required' if params[:interest_rate].blank?
      @loan_amount   = safe_float params[:loan_amount]
      @interest_rate = safe_float params[:interest_rate]
      @period        = safe_int params.fetch(:period, DEFAULT_PERIOD)
      @fees          = safe_int params.fetch(:fees, DEFAULT_FEES)
      @points        = safe_float params.fetch(:points, DEFAULT_POINTS)
    end

    def apr
      @apr ||= MortgageBuddy::AprCalculator.new(loan_amount:               @loan_amount,
                                                monthly_payment_with_fees: monthly_payment_with_fees,
                                                period:                    period,
                                                monthly_interest_rate:     monthly_interest_rate).apr
    end

    def monthly_payment
      @monthly_payment ||= calculate_monthly_payment(@loan_amount, monthly_interest_rate, @period)
    end

    def monthly_payment_with_fees
      @monthly_payment_with_fees ||= calculate_monthly_payment(@loan_amount + total_fees, monthly_interest_rate, @period)
    end

    def total_fees(negative_allowed = false)
      #fees may not be negative (borrower is not paid)
      total_fees = calculate_total_fees
      !negative_allowed && total_fees < 0 ? 0 : total_fees
    end

    private
    def calculate_monthly_payment(amount, monthly_rate, period)
      (amount * (monthly_rate/(1 - (1 + monthly_rate)**(-period)))).round(2)
    end

    def calculate_total_fees
      (@fees + (@loan_amount * points/100)).round(2)
    end
  end
end