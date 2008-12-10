Feature: Manage posts
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new post
    Given I am on the new post page
    When I fill in "Title:string" with "My post title:string"
    And I fill in "Body:text" with "My post body:text"
    And I fill in "Published:boolean" with "My post published:boolean"
    And I press "Create"
    Then I should see "My post title:string"
    And I should see "My post body:text"
    And I should see "My post published:boolean"

  Scenario: Delete post
    Given there are 4 posts
    When I delete the first post
    Then there should be 3 posts left
    
  More Examples:
    | initial | after |
    | 100     | 99    |
    | 1       | 0     |