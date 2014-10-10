class InvitationUserService
  constructor: (@http, @modal, @state, FormBindService) ->

  openInvitation: ->
    modalConfig =
      templateUrl: 'templates/invite.html',
      backdrop: false,
      keyboard: false

    @modal.open(modalConfig)

  createInvitation: (user) ->
    invitationPromise = $http.post('/user/invitation', user)
    formBind.bind($scope.invitationForm, invitationPromise)

    invitationPromise.then ->