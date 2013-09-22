Feature:
  As a blog administrator
  In order to  easily manage articles
  I want to be able to add and edit article categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Loading categories page
    Given I go to categories page 
    Then page must successfully load
    And I should see "Categories"
