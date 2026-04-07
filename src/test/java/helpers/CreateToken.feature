Feature: Create Token

Scenario: Create token for user login
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    # And request {"user":{"email":"jesus.quispe@globant.com","password":"Gabylu212208."}}
    # Changing to receive parameters
    And request {"user":{"email":"#(userEmail)","password":"#(userPassword)"}}
    # Check the update on the line above with karate-config.js configuration And request {"user":{"email":"#(email)","password":"#(password)"}}
    When method POST
    Then status 200
    * def authToken = response.user.token