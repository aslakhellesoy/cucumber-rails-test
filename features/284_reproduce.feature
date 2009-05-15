# https://rspec.lighthouseapp.com/projects/16211/tickets/284-rollbacks-not-working-as-expected
Feature: User log-in
  As a user
  I want to log in to the system
  So that I can manage my account
  
  Scenario: Inform the user of a bad login
    Given I am looking at the login page
		And the user "the user" exists with password "good pass"
    When I fill in "username" with "my username"
    And I fill in "password" with "wrong"
    And I press "Go"
		Then I should see "Username"