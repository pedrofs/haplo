angular.module('tccless').controller 'ProjectTasksCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskService'
  'TaskData'
  'TaskStatusService'
  ($scope, BreadcrumbService, TitleService, TaskService, TaskData, taskStatuses) ->
    $scope.removeTask = (id) ->
      TaskService.remove(id).then ->
        TaskData.remove(id)

    configureView = ->
      BreadcrumbService.use 'project_view.tasks'

    configureView()

    $scope.TaskData = TaskData
    $scope.taskStatuses = taskStatuses
]