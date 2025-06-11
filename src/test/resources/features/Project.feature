@project @regression
Feature: Project

  Background:
    Given base url https://api.clockify.me/api

  @addNewProject @smoke
  Scenario: Verify that creating a project returns 201 Created
    Given call Workspace.feature@getAllWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And set value Project 1 to practice of key name in body jsons/bodies/addNewProject.json
    When execute method POST
    Then the status code should be 201
    * define projectId2 = $.id
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId2}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And body jsons/bodies/archiveProjectUpdate.json
    And execute method PUT
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId2}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And execute method DELETE

  @getAllProjects
  Scenario: Verify that getting all projects returns 200 OK
    Given call Workspace.feature@getAllWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @findProjectById
  Scenario: Verify that getting a project by ID returns 200 OK
    Given call Project.feature@getAllProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 200

  @updateNoteProject
  Scenario:  Verify that updating a project's note returns 200 OK
    Given call Project.feature@getAllProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And set value Hi, this is my new note for the project. of key note in body jsons/bodies/updateNoteProject.json
    When execute method PUT
    Then the status code should be 200

  @deleteProject @smoke
  Scenario: Verify that deleting a project returns 200 OK
    Given call Workspace.feature@getAllWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And set value Project to be deleted of key name in body jsons/bodies/addNewProject2.json
    And execute method POST
    * define projectId1 = $.id
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId1}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And body jsons/bodies/archiveProjectUpdate.json
    And execute method PUT
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId1}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method DELETE
    Then the status code should be 200

  @updateProjectEstimate
  Scenario: Verify that updating the project estimate returns 200 OK
    Given call Project.feature@getAllProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    And header Content-Type = application/json
    And body jsons/bodies/archiveProjectUpdate.json
    When execute method PUT
    Then the status code should be 200

  @getAllProjectsUnauthorized
  Scenario: Verify that getting all projects without authorization returns 401 Unauthorized
    Given call Workspace.feature@getAllWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header x-api-key = ""
    When execute method GET
    Then the status code should be 401

  @projectNotFound
  Scenario: Verify that getting a project by invalid ID returns 404
    Given call Project.feature@getAllProjects
    And endpoint /v1/workspaces/{{workspaceId2}}/projects/{{projectId}}
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 404

  @getProjectBadRequest
  Scenario: Verify that getting a project by invalid ID returns 400
    Given call Project.feature@getAllProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/invalidProjectId123
    And header x-api-key = "OGU1YTNjYTQtOThmYy00NWNhLTlhOGYtMWMwNWM4YzA5M2U0"
    When execute method GET
    Then the status code should be 400