angular.module('tccless').controller 'NewTaskCtrl', [
  '$scope',
  '$http',
  'FormBindService',
  'TaskService',
  'TaskData'
  ($scope, $http, FormBindService, TaskData, TaskService) ->
    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createTask = (form) ->
      formBind = new FormBindService()

      task = new Task({task: $scope.task})
      creationPromisse = task.$save()

      formBind.bind(form, creationPromisse)

      creationPromisse.then (task) ->
        TaskData.add(task)
        $scope.$dismiss('created')
]
