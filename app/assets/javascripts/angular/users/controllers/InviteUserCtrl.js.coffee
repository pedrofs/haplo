angular.module('tccless').controller 'InviteUserCtrl', [
  '$scope',
  '$http',
  'UserService',
  'FormBindService'
  ($scope, $http, UserService, FormBindService) ->
    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createInvitation = (form, user) ->
      formBind = new FormBindService()
      invitationPromise = $http.post('/user/invitation', { user: user })

      formBind.bind(form, invitationPromise)

      invitationPromise.then (response) ->
        UserService.add(response.data.user)
        $scope.$dismiss('created')
]