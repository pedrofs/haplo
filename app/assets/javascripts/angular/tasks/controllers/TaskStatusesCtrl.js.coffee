angular.module('tccless').controller 'TaskStatusesCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskStatusService'
  'TaskStatusData'
  ($scope, BreadcrumbService, TitleService, TaskStatusService, TaskStatusData) ->
    $scope.removeStatus = (status) ->
      TaskStatusService.remove(status).then ->
        console.log status.id
        TaskStatusData.remove status.id

    configureView = ->
      BreadcrumbService.use 'task_statuses'
      TitleService.setTitle 'Status de tarefa'
      TitleService.setDescription 'Gerencie os status disponíveis para as tarefas'

    configureView()

    $scope.TaskStatusData = TaskStatusData
]