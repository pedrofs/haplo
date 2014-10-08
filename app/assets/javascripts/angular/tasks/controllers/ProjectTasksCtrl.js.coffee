angular.module('tccless').controller 'ProjectTasksCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskService'
  'TaskData'
  ($scope, BreadcrumbService, TitleService, TaskService, TaskData) ->
    configureView = ->
      BreadcrumbService.use 'project_view.tasks'

    configureView()
]