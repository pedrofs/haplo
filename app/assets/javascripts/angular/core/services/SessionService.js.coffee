angular.module('tccless').factory 'SessionService', ['$rootScope', 'localStorageService', ($rootScope, localStorageService) ->
  CURRENT_USER_KEY = 'current-user'

  obj =
    currentUser: localStorageService.get(CURRENT_USER_KEY)
    setCurrentUser: (user) ->
      localStorageService.set(CURRENT_USER_KEY, user)
      this.currentUser = user
    logout: ->
      localStorageService.set(CURRENT_USER_KEY, null)
      this.currentUser = null

  $rootScope.session = obj

  obj
]