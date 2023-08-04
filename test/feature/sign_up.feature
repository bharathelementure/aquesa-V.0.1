Feature: Sign Up/ CreateUser Account

    Scenario: User is able to Sign Up with valid email credential link
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {'Bharath'} phoneNo {'0123456789'} email {'bharath@gmail.com'} password {'qwertyuio'} confirm password{'qwertyuio'}
        And the BE will respond with empty notes list
        When I enter name {'Bharath'} into {0} text field
        And I enter phoneNo {'0123456789'} into {1} text field
        And I enter email {'bharath@gmail.com'} into {2} text field
        And I enter password {'qwertyuio'} into {3} text field
        And I enter confirm password {'qwertyuio'} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'Validation screen'} screen

    Scenario: User is not able to Sign Up with invalid email
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {'Bharath'} phoneNo {'0123456789'} email {'bharath.com'} password {'qwertyuio'} confirm password{'qwertyuio'}
        And the BE will respond with empty notes list
        When I enter name {'Bharath'} into {0} text field
        And I enter phoneNo {'0123456789'} into {1} text field
        And I enter email {'bharath.com'} into {2} text field
        And I enter password {'qwertyuio'} into {3} text field
        And I enter confirm password {'qwertyuio'} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'Enter a valid email'} error toast

    Scenario: User is not able to Sign Up with password and confirm password didn't match
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {'Bharath'} phoneNo {'0123456789'} email {'bharath@gmail.com'} password {'qwertyuio'} confirm password{'poiuytrew'}
        And the BE will respond with empty notes list
        When I enter name {'Bharath'} into {0} text field
        And I enter phoneNo {'0123456789'} into {1} text field
        And I enter email {'bharath@gmail.com'} into {2} text field
        And I enter password {'qwertyuio'} into {3} text field
        And I enter confirm password {'poiuytrew'} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'Password didn't match'} error toast

    Scenario: User is not able to Sign Up with password field is less than 6 character
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {'Bharath'} phoneNo {'0123456789'} email {'bharath@gmail.com'} password {'qwer'} confirm password{'qwer'}
        And the BE will respond with empty notes list
        When I enter name {'Bharath'} into {0} text field
        And I enter phoneNo {'0123456789'} into {1} text field
        And I enter email {'bharath@gmail.com'} into {2} text field
        And I enter password {'qwer'} into {3} text field
        And I enter confirm password {'qwer'} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'Please enter valid password(Min. 6 Character)'} error toast

    Scenario: User is not able to Sign Up with empty text fields
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {' '} phoneNo {' '} email {' '} password {' '} confirm password{' '}
        And the BE will respond with empty notes list
        When I enter name {' '} into {0} text field
        And I enter phoneNo {' '} into {1} text field
        And I enter email {' '} into {2} text field
        And I enter password {' '} into {3} text field
        And I enter confirm password {' '} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'Name cannot be empty, please enter a valid phoneNo, Enter a valid email, Password required to Sign Up'} error toast

    Scenario: User is able to Sign Up with valid email credential link
        Given I'm Sign up with Authenticate
        And the user should fill the text fields name {'Ragal Gurunath'} phoneNo {'9876543210'} email {'ragalgurunath@gmail.com'} password {'lkjhgfdsa'} confirm password{'lkjhgfdsa'}
        And the BE will respond with empty notes list
        When I enter name {'Ragal Gurunath'} into {0} text field
        And I enter phoneNo {'9876543210'} into {1} text field
        And I enter email {'ragalgurunath@gmail.com'} into {2} text field
        And I enter password {'lkjhgfdsa'} into {3} text field
        And I enter confirm password {'lkjhgfdsa'} into {4} text field
        And I tap {'FloatingActionButton >'} test and wait
        Then I see {'The email address is already in use by another account'} toast
        