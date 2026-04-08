
Feature: 'GET' Tests for the home page
//Implementing Backgroung as the url is the same for all scenarios

Background: Define URL
Given url apiURL
# Replaced by variable located on karate-config.js : https://conduit-api.bondaracademy.com/api/

Scenario: Get all tags ( asserts con contenido del response)

    Given path 'tags'
    When method GET
    Then status 200
    And match response.tags contains ['Test','Blog']
    And match response.tags !contains 'truck' 
    And match response.tags contains any ['Test','GEAI', "Nvidia"]
    And match response.tags !contains 'Selenium'
    And match response.tags == "#array"
    And match each response.tags == "#string"


Scenario: Get 10 articles (Assert con cantidad de artículos)
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == '#[10]'
    #And match response.articlesCount == 1
    And match response.articlesCount != 25
    #And match response == {'articles': "#array", 'articlesCount': 12}
    # All the lines below are commented due we are validating the whole json response.
    # And match response.articles[0].createdAt contains '2026'
    # And match response.articles[*].author.bio contains null
    # And match response..bio contains null
    # And match each response..following == false
    # And match each response..following == '#boolean'
    # And match each response..favoritesCount == '#number'
    # And match each response..bio == '##string'
    And match each response.articles ==
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """