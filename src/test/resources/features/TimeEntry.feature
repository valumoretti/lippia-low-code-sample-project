@timeEntry @regression
  Feature: Time Entry

    Background:
      Given base url https://api.clockify.me/api

    @getTimeEntry
    Scenario: Verify that getting time entry returns 200 Ok
      Given call Workspace.feature@getAllWorkspaces
      And call User.feature@getUserInfo
      And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
      And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
      And body jsons/bodies/getTimeEntry.json
      When execute method GET
      Then the status code should be 200
      And response should be $.[0].userId = "67fec9f9e20b814cf76adcbd"

    @addNewTimeEntry @smoke
    Scenario: Verify that adding a new time entry returns 201 Created
      Given call Workspace.feature@getAllWorkspaces
      And endpoint /v1/workspaces/{{workspaceId}}/time-entries
      And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
      And header Content-Type = application/json
      And body jsons/bodies/addNewTimeEntry.json
      When execute method POST
      Then the status code should be 201
      And response should be $.timeInterval.start = "2025-06-01T00:00:00Z"
      And response should be $.timeInterval.end = "2025-06-10T00:00:00Z"
      * define timeEntryId = $.id

    @updateTimeEntry
    Scenario: Verify that updating time entry returns 200 Ok
      Given call TimeEntry.feature@addNewTimeEntry
      And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
      And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
      And header Content-Type = application/json
      And set value 2025-05-25T00:08:00Z of key start in body jsons/bodies/addNewTimeEntry.json
      When execute method PUT
      Then the status code should be 200
      And response should be $.timeInterval.start = "2025-05-25T00:08:00Z"
      And response should be $.timeInterval.end = "2025-06-10T00:00:00Z"

    @deleteTimeEntry @smoke
    Scenario: Verify that deleting time entry returns 204 No Content
      Given call TimeEntry.feature@addNewTimeEntry
      And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
      And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
      When execute method DELETE
      Then the status code should be 204
      * print response