angular.module('tccless').controller 'NewTaskStatusCtrl', [
  '$scope'
  '$http'
  'FormBindService'
  'TaskStatusData'
  ($scope, $http, FormBindService, TaskStatusData) ->
    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createTaskStatus = (form) ->
      formBind = new FormBindService()

      creationPromisse = $http.post("/task_statuses.json", {task_status: $scope.taskStatus})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        TaskStatusData.add(response.data)
        $scope.$dismiss('created')

    $scope.taskStatus = {name: ''}
]
