angular.module('tccless').controller 'ProjectTasksCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskService'
  'TaskData'
  ($scope, BreadcrumbService, TitleService, TaskService, TaskData) ->
    $scope.removeTask = (id) ->
      TaskService.remove(id).then ->
        TaskData.remove(id)

    configureView = ->
      BreadcrumbService.use 'project_view.tasks'

    configureView()

    $scope.TaskData = TaskData
    $scope.search = {}
    $scope.search.status = 0
]