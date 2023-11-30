Feature: User can log in with either a Google or Github account by clicking on a corresponding button
  As a user of the app
  I must be able to log in with either a Google or Github account
  So that I don't have to create a new account on the app

Scenario: User Logs in with Google
  Given I am on the login page
  Then I should see "Sign In"
  And I press "Sign in with Google"
  Then I should see "National Map"

Scenario: User Logs in with GitHub
  Given I am on the login page
  Then I should see "Sign In"
  And I press "Sign in with GitHub"
  Then I should see "National Map"

Scenario: Logged into Account already
  Given I am on the login page
  When I press "Sign in with Google"
  And I go to the login page
  Then I should see "You are already logged in. Logout to switch accounts."

Scenario: Logout Account
  Given I go to the logout page
  Then I should see "You have successfully logged out."
