require 'spec_helper'

describe MortgageBuddy::StandardRounding do
  [{to_round: 23.3333, expected: 23.33},
   {to_round: 23.49833, expected: 23.50},
  ].each do |test_hash|
    it "rounds #{test_hash[:to_round]} to #{test_hash[:expected]}" do
      expect(described_class.round(test_hash[:to_round])).to eq(test_hash[:expected])
    end
  end
end