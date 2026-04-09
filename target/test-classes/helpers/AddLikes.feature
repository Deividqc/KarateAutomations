Feature: Add likes

Background:
    * url apiURL

Scenario: Add like to an article
    Given path 'articles', slug , 'favorite'
    And request {}
    When method POST
    Then status 200
    * def likesCount = response.article.favoritesCount