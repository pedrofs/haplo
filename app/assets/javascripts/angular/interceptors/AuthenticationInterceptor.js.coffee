@tccless.factory 'AuthenticationInterception', ['$location', 'SessionService', ($location, SessionService) ->
  obj =
    # responseError: (response) ->
    #   if response.status == 401
    #     $location.path('/login')

    request: (config) ->
      return config if config.url.match /templates/
      return config unless SessionService.currentUser?

      config.headers["X-User-Email"] = SessionService.currentUser.email
      config.headers["X-User-Token"] = SessionService.currentUser.authentication_token

      config

  return obj
]

@tccless.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push 'AuthenticationInterception'
]