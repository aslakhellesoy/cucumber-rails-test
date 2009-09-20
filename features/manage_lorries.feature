Feature: Manage lorries
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new lorry
    Given I have gone to the new lorry page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1 - this is from before filter"

  Scenario: Delete lorry
    Given the following lorries:
      | name   | colour |
      | name 1 | green  |
      | name 2 | yellow |
      | name 3 | pink   |
      | name 4 | blue   |
    When I delete the 3rd lorry
    Then I should see the following lorries:
      | name   | colour |
      | name 1 | green  |
      | name 2 | yellow |
      | name 4 | blue   |
    And I should see the following lorries in a definition list:
      | name 1 | green  |
      | name 2 | yellow |
      | name 4 | blue   |
    And I should see the following lorries in an ordered list:
      | name 1 |
      | name 2 |
      | name 4 |

  Scenario: ensure use_transactional_fixtures is working and rolling DB back
    Given I have not created any lorries in this scenario
    But the previous scenarios have
    Then there should be 0 lorries
  
  @wip
  Scenario: This is currently failing
    Given I have 45 pink lorries

  @wip
  Scenario: Delete the 4th magic lorry, which always raises an error
    Given the following lorries:
      | name   | colour |
      | name 1 | green  |
      | name 2 | yellow |
      | name 3 | pink   |
      | name 4 | blue   |
    When I delete the 4th lorry
