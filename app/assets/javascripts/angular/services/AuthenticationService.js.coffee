class AuthenticationService
  constructor: (@http, @SessionService) ->

  login: (email, password) ->
    @http.post('/user/sign_in', {
        email: email,
        password: password
      }).then((response) =>
        @SessionService.setCurrentUser(response.data)
      )

@tccless.service 'AuthenticationService', ['$http', 'SessionService', AuthenticationService]