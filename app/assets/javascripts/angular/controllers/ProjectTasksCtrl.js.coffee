@tccless.controller 'ProjectTasksCtrl', [
  '$scope',
  'TaskService',
  'TaskData'
  ($scope, TaskService, TaskData) ->
    console.log 'task controller'
]