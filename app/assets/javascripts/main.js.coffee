@tccless = angular.module('tccless', ['ngRoute', 'ngResource', 'ui.router', 'ui.bootstrap', 'LocalStorageModule'])

@tccless.config [
  '$routeProvider',
  '$stateProvider',
  ($routeProvider, $stateProvider) ->
    $routeProvider.otherwise({
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/welcome.html'
    })

    $stateProvider.
      state('public', {
        abstract: true,
        templateUrl: 'templates/public.html'
      }).
      state('public.start-now', {
        url: '/start-now',
        controller: 'StartNowCtrl',
        templateUrl: 'templates/start-now.html'
      }).
      state('public.login', {
        url: '/login',
        controller: 'LoginCtrl',
        templateUrl: 'templates/login.html'
      }).
      state('public.welcome', {
        url: '/',
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/welcome.html'
      }).
      state('private', {
        abstract: true,
        templateUrl: 'templates/private.html'
      }).
      state('private.users', {
        url: '/users',
        controller: 'UsersCtrl',
        templateUrl: 'templates/users.html',
        resolve: {
          users: ['UserService', (UserService) ->
            UserService.all()
          ]
        }
      }).
      state('private.logout', {
        url: '/logout'
      })
]