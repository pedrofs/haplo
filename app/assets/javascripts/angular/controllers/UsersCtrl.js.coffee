angular.module('tccless').controller 'UsersCtrl', [
  '$scope',
  '$modal',
  'BreadcrumbService',
  'TitleService',
  'UserService',
  'md5'
  ($scope, $modal, BreadcrumbService, TitleService, UserService, md5) ->
    configureView = ->
      BreadcrumbService.reset()
      BreadcrumbService.addItem('Usuários')
      TitleService.setTitle('Usuários')
      TitleService.setDescription('Lista de todos os usuários: confirmados e pendentes.')

    $scope.createHash = (text) ->
      md5.createHash text

    configureView()
    $scope.UserService = UserService
]