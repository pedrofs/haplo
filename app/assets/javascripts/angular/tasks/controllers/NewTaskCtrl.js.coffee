angular.module('tccless').controller 'NewTaskCtrl', [
  '$scope'
  '$http'
  'FormBindService'
  'TaskData'
  'ProjectData'
  'UserService'
  'TaskStatusService'
  ($scope, $http, FormBindService, TaskData, ProjectData, UserService, TaskStatusService) ->
    getAssignedId = ->
      if $scope.task.assigned then $scope.task.assigned.id else false
    getStatusId = ->
      if $scope.task.task_status then $scope.task.task_status.id else false

    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createTask = (form) ->
      formBind = new FormBindService()

      projectId = ProjectData.currentProject.id

      $scope.task.project_id = projectId
      $scope.task.assigned_id = getAssignedId()
      $scope.task.task_status_id = getStatusId()

      creationPromisse = $http.post("/projects/#{projectId}/tasks.json", {task: $scope.task})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        TaskData.add(response.data.task)
        $scope.$dismiss('created')

    UserService.all().then (users) ->
      $scope.users = users
    TaskStatusService.all().then (response) ->
      $scope.taskStatuses = response.data


    $scope.ProjectData = ProjectData
    $scope.task = {}
]
