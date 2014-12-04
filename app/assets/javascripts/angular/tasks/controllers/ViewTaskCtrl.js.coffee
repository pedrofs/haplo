angular.module('tccless').controller 'ViewTaskCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TabWidgetService'
  'task'
  ($scope, BreadcrumbService, TitleService, TabWidgetService, task) ->
    configureView = ->
      BreadcrumbService.use 'view_task', { label: "Tarefa: #{task.title}" }
      TitleService.setTitle "#{task.title}"

    configureView()

    $scope.tabs = TabWidgetService.getTabs('tasks')

    stateParam =
      taskId: task.id
    $scope.tabStateParam = JSON.stringify stateParam
]