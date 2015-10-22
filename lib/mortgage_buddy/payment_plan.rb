module MortgageBuddy
  class PaymentPlan
    class << self
      def build(params)
        new(params).payments
      end
    end

    def initialize(params)
      @loan_amount           = params[:loan_amount]
      @monthly_payment       = params[:monthly_payment]
      @monthly_interest_rate = params[:monthly_interest_rate]
      @remaining_loan_amount = @loan_amount
    end

    def payments
      @payments ||= build_payments
    end

    def build_payments
      payments       = []
      payment_number = 1
      while @remaining_loan_amount > 0.0
        interest               = next_payment_interest
        principal              = next_payment_principal(interest)
        payment                = interest + principal
        @remaining_loan_amount = (@remaining_loan_amount - principal).round(2)
        payments << OpenStruct.new(payment:   payment,
                                   interest:  interest,
                                   principal: principal,
                                   number:    payment_number,
                                   balance:   @remaining_loan_amount)
        payment_number += 1
      end
      payments
    end

    def next_payment_principal(interest)
      principal = @monthly_payment - interest
      if principal > @remaining_loan_amount
        principal = @remaining_loan_amount
      end
      principal.round(2)
    end

    def next_payment_interest
      (@monthly_interest_rate * @remaining_loan_amount * 100).floor.to_f / 100
    end
  end
end