Feature: Sign in

    Scenario: User is able to sign in with valid credentials
        Given I'm logged in
        And the user with credentials {'bharath@gmail.com'} {'0987uiowdc'} is registered
        And the BE will respond with empty notes list
        When I enter {'bharath@gmail.com'} into {0} text field
        And I enter {'0987uiowdc'} into {1} text field
        And I tap {'SIGN IN'} test and wait
        Then I see {'Home Screen'} screen

    Scenario: User is not able to sign in with empty password
        Given I'm not logged in
        And the user with invalid credentials {'bharath@gmail.com'} empty password {' '} is registered
        And the BE will reject any credentials
        And the app is running
        When I enter {'bharath@gmail.com'} into {0} text field
        And I enter {' '} into {1} text field
        And I tap {'SIGN IN'} test and wait
        Then I see {'Invalid email and password'} toast message

    Scenario: User is not able to sign in with empty text fields
        Given I'm not logged in
        And the user with invalid credentials empty email {' '} empty password {' '}
        And the BE will reject any credentials
        And the app is running
        When I enter {' '} into {0} text field
        And I enter {' '} into {1} text field
        And I tap {'SIGN IN'} test and wait
        Then I see {'Email and Password fields are empty Enter a valid email and password'}

    Scenario: User is not able to sign in with another email account without signUp
        Given I'm not logged in
        And the user with invalid credentials email {'ragalgurunath@gmail.com'} password {'qwertyuio'}
        And the BE will reject any credentials
        And the app is running
        When I enter {'ragalgurunath@gmail.com'} into {0} text field
        And I enter {'qwertyuio'} into {1} text field
        And I tap {'SIGN IN'} test and wait
        Then I see {'Customer not found please SignUp to Authenticate'}
