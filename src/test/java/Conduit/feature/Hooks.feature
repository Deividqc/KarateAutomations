Feature: Learning about Hooks
    As a test automation engineer
    I want to understand how to use hooks in Cucumber
    So that I can set up and tear down test scenarios properly

    Background: hooks
         * def result = callonce read('classpath:helpers/Dummy.feature')
         * def username = 'noname'

    #after hooks
        * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature')}
        * configure afterFeature =
        """
            function(){ 
                karate.log('After feature text')
            }
        """
    Scenario: Execute Before hook before scenario
        * print username
        * print 'this is the first scenario'
       
    Scenario: Execute After hook after scenario
        * print username
        * print 'this is the second scenario'
    