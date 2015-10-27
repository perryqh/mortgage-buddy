module MortgageBuddy
  class StandardRounding
    class << self
      def round(num)
        num.round(2)
      end
    end
  end
end