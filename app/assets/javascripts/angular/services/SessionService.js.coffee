@tccless.factory 'SessionService', ['$rootScope', 'localStorageService', ($rootScope, localStorageService) ->
  CURRENT_USER_KEY = 'current-user'

  obj =
    currentUser: localStorageService.get(CURRENT_USER_KEY)
    setCurrentUser: (user) ->
      localStorageService.set(CURRENT_USER_KEY, user)
      this.currentUser = user

  $rootScope.session = obj

  obj
]