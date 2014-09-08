@tccless.controller 'LoginCtrl', [
  '$scope',
  '$state',
  'AuthenticationService',
  ($scope, $state, authenticationService) ->
    $('body').addClass('login-layout light-login')

    $scope.createSession = (user) ->
      authenticationService.login(user.email, user.password).then( ->
        $('body').removeClass('login-layout').removeClass('light-login')
        $state.go('private.users')
      )
]
