Feature:
  As a blog administrator
  In order to make sure articles have original content
  I want to be able to merge articles

  Background:
    Given the blog is set up
    And two similar articles are published
    

  Scenario: Seeing merge form in edit article page
    Given I am logged into the admin panel
    When I follow to edit page of first article
    Then I should see "Merge Articles"
    And I should see button "Merge"

  Scenario: Merging two articles
    Given I am logged into the admin panel
    When I follow to edit page of first article
    And I input second article id in Article ID field
    And I press "Merge"
    Then I should be redirected to articles page
    And I should see "Articles successfully merged"
  
  Scenario: A non-admin cannot merge two articles
    Given I am logged in as non-admin
    When I follow to edit page of first article
    Then I should not see "Merge Articles"
    When I post to merge path 
    Then I should be redirected to admin panel

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    When I follow to edit page of first article
    And I input second article id in Article ID field
    And I press "Merge"
    Then articles should be merged



    