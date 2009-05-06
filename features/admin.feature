Feature: title
  In order to keep control of website information
  As an admin
  I want to be able to do basic CRUD on my resources
 
  Background: 
    Given an admin user Philip exists
    When I login as Philip
    Then I should be logged in as Philip

  Scenario: Foo
    Given there are 3 customer
 
  Scenario Outline: Admin can view resources
    Given there are 3 <object>
    When I goto admin_<collection>
    Then I should see a list of <item>
 
    Examples:
      | object   | collection | item     |
      | customer | customers  | customer |
      | feed     | feeds      | feed     |
