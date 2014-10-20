angular.module('tccless').controller 'ProjectTasksCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskService'
  'TaskData'
  'tasks'
  ($scope, BreadcrumbService, TitleService, TaskService, TaskData, tasks) ->
    configureView = ->
      BreadcrumbService.use 'project_view.tasks'

    configureView()

    $scope.TaskData = TaskData
]