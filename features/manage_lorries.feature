Feature: Manage lorries
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new lorry
    Given I am on the new lorry page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Delete lorry
    Given the following lorries:
      |name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    When I delete the 3rd lorry
    Then I should see the following lorries:
      |name|
      |name 1|
      |name 2|
      |name 4|
