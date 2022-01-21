Feature: Pay Off
  As a borrower who has a small gap between buying new
  house and selling current house
  I would like to know the total fees

  Scenario Outline: PayOff
    Given a loan amount of $<loan_amount>
    And an interest rate of <interest_rate>%
    And fees $<fees>
    And points $<points>
    And a period of <period>
    And a payoff on payment number <payoff_payment_num>
    Then the total paid fees are $<total_paid_fees>

    Scenarios: with required payment fields
      | loan_amount | interest_rate | fees | points | period | payoff_payment_num | total_paid_fees |
      | 165000      | 4.5           | f    | 0      | 360    | 1                  | 836.03          |

