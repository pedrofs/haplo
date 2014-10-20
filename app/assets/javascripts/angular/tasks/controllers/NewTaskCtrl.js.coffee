angular.module('tccless').controller 'NewTaskCtrl', [
  '$scope'
  '$http'
  'FormBindService'
  'TaskData'
  'ProjectData'
  'UserService'
  ($scope, $http, FormBindService, TaskData, ProjectData, UserService) ->
    getAssignedId = ->
      if $scope.task.assigned then $scope.task.assigned.id else false

    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createTask = (form) ->
      formBind = new FormBindService()

      projectId = ProjectData.currentProject.id

      $scope.task.project_id = projectId
      $scope.task.assigned_id = getAssignedId()

      creationPromisse = $http.post("/projects/#{projectId}/tasks.json", {task: $scope.task})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        TaskData.add(response.data)
        $scope.$dismiss('created')

    UserService.all().then (users) ->
      $scope.users = users

    $scope.ProjectData = ProjectData
    $scope.task = {}
]
