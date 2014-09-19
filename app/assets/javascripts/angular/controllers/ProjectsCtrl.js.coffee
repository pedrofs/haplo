@tccless.controller 'ProjectsCtrl', [
  '$scope',
  'BreadcrumbService',
  'TitleService',
  'ProjectService'
  ($scope, BreadcrumbService, TitleService, ProjectService) ->
    configureView = ->
      BreadcrumbService.reset()
      BreadcrumbService.addItem('Projetos')
      TitleService.setTitle('Projetos')
      TitleService.setDescription('Lista de todos os projetos.')

    configureView()
    $scope.ProjectService = ProjectService
]