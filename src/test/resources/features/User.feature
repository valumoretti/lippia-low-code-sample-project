@user @regression
Feature: User

  @getUserInfo @smoke
  Scenario: Verify that getting currently logged-in user's info returns 200 Ok
    Given base url https://api.clockify.me/api
    And endpoint /v1/user
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 200
    And response should be $.name = "valumorettiarias"
    * print response
    * define userId = $.id