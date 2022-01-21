# frozen_string_literal: true

module MortgageBuddy
  class PaymentPlan
    class << self
      def build(params)
        new(params).payments
      end
    end

    attr_reader :loan_amount, :monthly_payment, :monthly_interest_rate, :interest_rounding_strategy, :period,
                :remaining_loan_amount

    def initialize(params)
      params.each_key do |key|
        instance_variable_set("@#{key}", params[key])
      end
      @interest_rounding_strategy ||= MortgageBuddy::StandardRounding
      @remaining_loan_amount      = @loan_amount
    end

    def payments
      @payments ||= build_payments
    end

    def build_payments
      payments       = []
      payment_number = 1
      while remaining_loan_amount > 0.0
        interest               = next_payment_interest
        principal              = next_payment_principal(interest, payments.length + 1)
        payment                = interest + principal
        @remaining_loan_amount = (remaining_loan_amount - principal).round(2)
        payments << OpenStruct.new(payment: payment.round(2),
                                   interest: interest,
                                   principal: principal,
                                   number: payment_number,
                                   balance: remaining_loan_amount)
        payment_number += 1
      end
      payments
    end

    def next_payment_principal(interest, payment_number)
      principal = monthly_payment - interest
      principal = remaining_loan_amount if principal > remaining_loan_amount || last_payment?(payment_number)
      principal.round(2)
    end

    def next_payment_interest
      interest_rounding_strategy.round(monthly_interest_rate * remaining_loan_amount)
    end

    def last_payment?(payment_number)
      period == payment_number
    end
  end
end
