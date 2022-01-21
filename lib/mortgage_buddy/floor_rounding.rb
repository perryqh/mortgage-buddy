# frozen_string_literal: true

module MortgageBuddy
  class FloorRounding
    class << self
      def round(num)
        (num * 100).floor.to_f / 100
      end
    end
  end
end
