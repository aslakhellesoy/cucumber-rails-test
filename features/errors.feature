Feature: See errors
  In order to fix errors
  Developers should see Rails errors bubble up

  Scenario: Visit nonexistent page
    When I visit a nonexistent page
    Then the Ruby error message should match 'No route matches "/does/not/exist"'

  Scenario: Visit failing page
    When I visit a failing page
    Then the Ruby error message should match 'FAIL'
