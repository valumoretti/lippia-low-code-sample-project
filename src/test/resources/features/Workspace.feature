@workspace @regression
Feature: Workspace

  Background:
    Given base url https://api.clockify.me/api

  @getAllWorkspacesNoOk
  Scenario: Verify that getting all my workspaces returns a 401 response
    And endpoint /v1/workspaces
    And header x-api-key = ""
    When execute method GET
    Then the status code should be 401
    And response should be $.message = "Api key does not exist"

  @getAllWorkspaces @smoke
  Scenario: Verify that getting all my workspaces returns a 200 OK response
    And endpoint /v1/workspaces
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].name = "automation"
    And response should be $.[0].hourlyRate.currency = "USD"
    And response should be $.[0].memberships.[0].userId = "67fec9f9e20b814cf76adcbd"
    * define workspaceId = $.[0].id
    * define workspaceId2 = $.[1].id
    * print response