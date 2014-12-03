angular.module('tccless').controller 'NewTimelogCtrl', [
  '$scope'
  '$http'
  'FormBindService'
  'TimelogData'
  'SessionService'
  ($scope, $http, FormBindService, TimelogData, SessionService) ->
    getTaskId = ->
      if $scope.timelog.task then $scope.timelog.task.id else false

    $scope.createTimelog = (form) ->
      formBind = new FormBindService()

      $scope.timelog.task_id = getTaskId()

      creationPromisse = $http.post("/timelogs.json", {timelog: $scope.timelog})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        TimelogData.add(response.data.timelog)
        $scope.$dismiss('created')

    $http.get("/users/#{SessionService.currentUser.id}/tasks.json").then (response) ->
      $scope.tasks = response.data.tasks

    $scope.timelog = {}
]
