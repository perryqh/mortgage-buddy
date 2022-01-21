# frozen_string_literal: true

module MortgageBuddy
  module Monthly
    def monthly_interest_rate
      @interest_rate / 12 / 100
    end
  end
end
