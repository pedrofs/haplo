angular.module('tccless').controller 'ConfirmInvitationCtrl', [
  '$scope'
  '$http'
  '$state'
  '$stateParams'
  'FormBindService'
  'SessionService'
  ($scope, $http, $state, $stateParams, FormBindService, SessionService) ->
    $('body').addClass('login-layout light-login')

    $scope.acceptInvitation = (form) ->
      formBind = new FormBindService()
      promise = $http.put('/user/invitation', {user: $scope.user})
      formBind.bind(form, promise)

      promise.then (response) ->
        $state.go('public.login')

    $scope.user = {name: '', invitation_token: $stateParams.invitationToken}
]