Feature: Manage Lorries without transactions

  @no-txn
  Scenario: Delete lorry
    Given the following lorries:
      | name   | colour |
      | name 1 | green  |
      | name 2 | yellow |
      | name 3 | pink   |
      | name 4 | blue   |

  @clean_lorries_afterwards
  @no-txn
  Scenario: ensure @no_txn is working not rolling back DB
    Given I have not created any lorries in this scenario
    But the previous scenarios have
    Then there should be 4 lorries
