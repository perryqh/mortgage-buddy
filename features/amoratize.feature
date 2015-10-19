Feature: Amoratize
  In order to know more about the cost of a loan
  As a borrower
  I want to see monthly payments and total interest paid

  Scenario Outline: Amoratization
    Given a loan amount of $<loan_amount>
    And an interest rate of <interest_rate>%
    And a period of <period>
    And an extra monthly payment of $<extra_monthly_payment>
    Then the monthly payment should be $<actual_monthly_payment>
    And the total interest paid should be $<total_interest>
    And the number of payments should be <total_num_payments>

    Scenarios: with required Amoratization fields
      | loan_amount | interest_rate | period | extra_monthly_payment | actual_monthly_payment | total_interest | total_num_payments |
      | 125000      | 3.5           | 360    | 0                     | 561.31                 | 77065.86       | 360                |
      | 550000      | 3.0           | 360    | 0                     | 2318.82                | 284773.56      | 360                |
      | 550000      | 3.0           | 360    | 3000                  | 5318.82                | 87142.65       | 120                |
      | 550000      | 3.0           | 360    | 4000                  | 6318.82                | 71016.65       | 99                 |