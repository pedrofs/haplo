angular.module('tccless').controller 'TasksCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TaskData'
  ($scope, BreadcrumbService, TitleService, TaskData) ->
    configureView = ->
      BreadcrumbService.use 'tasks'
      TitleService.setTitle 'Minhas Tarefas'
      TitleService.setDescription 'A lista de suas tarefas. Marque <b>Hoje</b> nas tarefas para cronometrá-las.'

    configureView()
    $scope.TaskData = TaskData
    $scope.search = {}
    $scope.search.status = 0
]