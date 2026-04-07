Feature: 'Post' Create new users

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.generateRandomEmail()
    * def randomUsername = dataGenerator.generateRandomUsername()

     Given url apiURL

@ignore
Scenario: Sign UP for new user
    Given def userData = {"email": "TstUser8@mydomain.com", "username": "TstUser8"}
    Given path 'users'
    And request {"user":{"email": #(userData.email),"password": "12345678", "username": #(userData.username)}};
    When method POST
    Then status 201

@ignore
Scenario: Sign up new user with multiline JSON expression
    Given def userData = {"email": "TstUser9@mydomain.com", "username": "TstUser9"}
    Given path 'users'
    And request
    """
    {
        "user": {
             "email": #(userData.email),
             "password": "12345678",
             "username": #(userData.username)
        }
    }
    """
    When method POST
    Then status 201


Scenario: Sign up new user with data generator
    #Line replaced by data generator variables and method calls
    #Given def userData = {"email": "TstUser9@mydomain.com", "username": "TstUser9"}

    Given path 'users'
    And request
    """
    {
        "user": {
             "email": #(randomEmail),
             "password": "12345678",
             "username": #(randomUsername)
        }
    }
    """
    When method POST
    Then status 201
    And match response ==
    """
    {
        "user": 
        {
            "id": "#number",
            "email": #(randomEmail),
            "username": #(randomUsername),
            "bio": "##string",
            "image": "#string",
            "token": "#string"
        }
    }
    """
    
    Scenario: Error message when trying to sign up with an existing user
        

    Given path 'users'
    And request
    """
    {
        "user": {
             "email": "TstUser9@mydomain.com",
             "password": "12345678",
             "username": #(randomUsername)
        }
    }
    """
    When method POST
    Then status 422

    @NewUser
    Scenario Outline: Error messages by field when trying to sign with an existing user
    
    Given path 'users'
    And request
    """
    {
        "user": {
             "email": "<email>",
             "password": "<password>",
             "username": "<username>"
        }
    }
    """
    When method POST
    Then status 422
    And match response == <errorResponse>

    Examples:
        | email                 | password | username          | errorResponse                                                                            |
        | #(randomEmail)        | 12345678 | TstUser9          | {"errors":{"username":["has already been taken"]}}                                       |
        | TstUser9@mydomain.com | 12345678 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}                                          |
        | TstUser9@mydomain.com | 12345678 | TstUser9          | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}}    |