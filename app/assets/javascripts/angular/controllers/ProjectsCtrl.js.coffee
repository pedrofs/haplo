@tccless.controller 'ProjectsCtrl', [
  '$scope',
  'BreadcrumbService',
  'TitleService',
  ($scope, BreadcrumbService, TitleService) ->
    configureView = ->
      BreadcrumbService.reset()
      BreadcrumbService.addItem('Projetos')
      TitleService.setTitle('Projetos')
      TitleService.setDescription('Lista de todos os projetos.')

    $scope.projects = [
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
      {name: 'Nome do projeto'},
    ]

    configureView()
]