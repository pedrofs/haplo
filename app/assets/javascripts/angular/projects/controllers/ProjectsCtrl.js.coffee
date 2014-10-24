angular.module('tccless').controller 'ProjectsCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'ProjectService'
  'FavoriteProjectData'
  ($scope, BreadcrumbService, TitleService, ProjectService, FavoriteProjectData) ->
    configureView = ->
      BreadcrumbService.use('projects')
      TitleService.setTitle('Projetos')
      TitleService.setDescription('Lista de todos os projetos.')

    configureView()
    $scope.ProjectService = ProjectService
    $scope.FavoriteProjectData = FavoriteProjectData
]