angular.module('tccless').controller 'ProjectsCtrl', [
  '$scope',
  'BreadcrumbService',
  'TitleService',
  'ProjectService'
  ($scope, BreadcrumbService, TitleService, ProjectService) ->
    configureView = ->
      BreadcrumbService.use('projects')
      TitleService.setTitle('Projetos')
      TitleService.setDescription('Lista de todos os projetos.')

    configureView()
    $scope.ProjectService = ProjectService
]