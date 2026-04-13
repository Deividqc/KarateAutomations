Feature: Work with DB

Background: connect to db
    * def dbConfig = Java.type('helpers.DbHandler')


Scenario Outline: Seed database with a  new job
    * eval dbConfig.addNewClientWithId(<IdClient>, "<FirstName>", "<LastName>", "<Email>", "<PhoneNumber>", "<DateJoined>")

    Examples:
    | IdClient | FirstName | LastName    | Email                       | PhoneNumber  |DateJoined |
    | 55       | Julio     | Chavez      | julio.chavez@hotmail.com    | 555-9901-4444|2023-02-22 |
    | 56       | Jose      | Landauri    | jose.landauri@hotmail.com   | 555-9902-4444|2023-02-23 |
    | 57       | Maria     | Rodriguez   | maria.rodriguez@hotmail.com | 555-9903-4444|2023-02-24 |
    | 58       | Ana       | Perez       | ana.perez@hotmail.com       | 555-9904-4444|2023-02-25 |

@debug
Scenario Outline: Get loan data from a client by id
    * def loans = dbConfig.getDataLoanByClientId(<ClientId>)
    * print loans.FirstName
    * print loans.LastName
    * print loans.LoanID
    * print loans.LoanAmount

    Examples:
    | ClientId |
    | 1        |
    | 2        |
    | 3        |
    | 4        | 

