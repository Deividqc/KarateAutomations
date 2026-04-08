
Feature: 'Post' Tests for submitting articles

Background: Define URL
    # This section is commented out since we are calling the CreateToken.feature which already has the url defined, 
    # if we leave it here it will override the url defined in the CreateToken.feature and the test will fail since 
    # the url is different for the login and for the articles.
    # Replaced by last line below of this section
    # Given url apiURL
    # Given path 'users/login'
    # And request {"user":{"email":"jesus.quispe@globant.com","password":"Gabylu212208."}}
    # When method POST
    # Then status 200
    # * def token = response.user.token
    # Changing function call by callonce, to read only one the create Token feature and reuse the token for all scenarios.
    # Add parameters to be executed by anyone.
    # This line is deprecated since we implemented gathering token on karate-config.js
    # * def tokenResponse  = callonce read('classpath:helpers/CreateToken.feature') 
    # Replaced by configurations in karate-config.js : {"email":"jesus.quispe@globant.com","password":"Gabylu212208."}
    # This line is deprecated since we implemented gathering tokenon karate-config.js
    # * def token = tokenResponse.authToken
    * url apiURL
    * def articleRequestbody = read('classpath:resources/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestbody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestbody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestbody.article.body = dataGenerator.getRandomArticleValues().body
    * set articleRequestbody.article.tagList = dataGenerator.getRandomArticleValues().tagList

@ignore
Scenario: Create a new article
    
    Given path 'articles'
    # This line is deprecated since we implemented gathering token on karate-config.js
    # And header Authorization = 'Token ' + token
    And request {"article": {"title": "New title 1", "description": "About new title 1", "body": "Body title New Title 1", "tagList": ["tag new title 1"]}}
    When method POST
    Then status 201
    And match response.article.title == "New title 1"


Scenario: Create a new article from JSON file
    
    Given path 'articles'
    And request articleRequestbody
    When method POST
    Then status 201
    And match response.article.title == articleRequestbody.article.title


Scenario: Create and delete new article
    
    Given path 'articles'
    # This line is deprecated since we implemented gathering token on karate-config.js
    # And header Authorization = 'Token ' + token
    And request {"article": {"title": "New title 2", "description": "About new title 2", "body": "Body title New Title 2", "tagList": ["tag new title 2"]}}
    When method POST
    Then status 201
    And match response.article.title == "New title 2"
    * def articleslug = response.article.slug
    * def articletitle = response.article.title

    Given path 'articles/' + articleslug
    # This line is deprecated since we implemented gathering token on karate-config.js
    # And header Authorization = 'Token ' + token
    When method DELETE
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[*].title !contains articletitle
   