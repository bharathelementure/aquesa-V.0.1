Feature: ForgotPassword

    Scenario: Forgot password able to send an email to reset your password
        Given I have Forgot password with Authenticate
        And the user should fill the text field email {'bharath@gmail.com'} is registered
        And the BE will respond with empty notes list
        When I enter {'bharath@gmail.com'} into {0} text field
        And I tap {'Reset Password'} test and wait
        Then I see {'Sign In Screen'} screen
        And check the mail to Reset the password
        And click on the link to Reset password

    Scenario: Forgot password not able to send an email due to invalid email
        Given I have Forgot password with Authenticate
        And the user should fill the text field email {'bharath.com'}
        And the BE will respond with empty notes list
        When I enter {'bharath.com'} into {0} text field
        And I tap {'Reset Password'} test and wait
        Then I see {'Enter a valid a email to reset the password'} error toast

    Scenario: Forgot password not able to send an email due to empty string
        Given I have Forgot password with Authenticate
        And the user should fill the text field emial {' '}
        And the BE will respond with empty note list
        When I enter {' '} into {0} text field
        And I tap {'Reset Password'} test and wait
        Then I see {'Enter a valid email to reset the password'} error toast