angular.module('tccless').controller 'UsersCtrl', [
  '$scope',
  '$modal',
  'BreadcrumbService',
  'TitleService',
  'UserService'
  ($scope, $modal, BreadcrumbService, TitleService, UserService) ->
    configureView = ->
      BreadcrumbService.use 'users'
      TitleService.setTitle 'Usuários'
      TitleService.setDescription 'Lista de todos os usuários: confirmados e pendentes.'

    configureView()
    $scope.UserService = UserService
]