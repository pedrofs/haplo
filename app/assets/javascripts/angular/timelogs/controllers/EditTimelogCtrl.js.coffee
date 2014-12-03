angular.module('tccless').controller 'EditTimelogCtrl', [
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

      creationPromisse = $http.put("/timelogs/#{TimelogData.currentTimelog.id}.json", {timelog: $scope.timelog})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        TimelogData.remove response.data.id
        TimelogData.add response.data
        TimelogData.currentTimelog = null
        $scope.$dismiss('created')

    $http.get("/users/#{SessionService.currentUser.id}/tasks.json").then (response) ->
      $scope.tasks = response.data.tasks

    $scope.timelog = angular.copy(TimelogData.currentTimelog)
]
