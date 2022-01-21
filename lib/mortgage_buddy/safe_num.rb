# frozen_string_literal: true

module MortgageBuddy
  module SafeNum
    def safe_float(the_float)
      Float(the_float.to_s)
    end

    def safe_int(the_int)
      Integer(the_int.to_s)
    end
  end
end
