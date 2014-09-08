@tccless.controller 'UsersCtrl', [
  '$scope',
  '$modal',
  'BreadcrumbService',
  'TitleService',
  'UserService'
  ($scope, $modal, BreadcrumbService, TitleService, UserService) ->
    $scope.UserService = UserService

    BreadcrumbService.reset()
    BreadcrumbService.addItem('Usuários')
    TitleService.setTitle('Usuários')
    TitleService.setDescription('Lista de todos os usuários: confirmados e pendentes.')

    $scope.newInvitation = ->
      openModal()

    openModal = ->
      modalConfig =
        templateUrl: 'templates/invite.html',
        backdrop: false,
        keyboard: false,
        controller: 'InviteUserCtrl'

      $modal.open(modalConfig)
]