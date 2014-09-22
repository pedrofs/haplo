@tccless = angular.module('tccless', ['ngRoute', 'ngResource', 'ui.router', 'ui.bootstrap', 'LocalStorageModule', 'angular-md5', 'daterangepicker', 'gantt', 'ngColorPicker'])

@tccless.config [
  '$routeProvider',
  '$stateProvider',
  ($routeProvider, $stateProvider) ->
    $routeProvider.otherwise({
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/pages/welcome.html'
    })

    $stateProvider.
      state('public', {
        abstract: true,
        templateUrl: 'templates/layouts/public.html'
      }).
      state('public.start-now', {
        url: '/start-now',
        controller: 'StartNowCtrl',
        templateUrl: 'templates/pages/start-now.html'
      }).
      state('public.login', {
        url: '/login',
        controller: 'LoginCtrl',
        templateUrl: 'templates/pages/login.html'
      }).
      state('public.welcome', {
        url: '/',
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/pages/welcome.html'
      }).
      state('private', {
        abstract: true,
        templateUrl: 'templates/layouts/private.html'
      }).
      state('private.users', {
        url: '/users',
        controller: 'UsersCtrl',
        templateUrl: 'templates/users/users.html',
        resolve: {
          users: ['UserService', (UserService) ->
            UserService.all()
          ]
        }
      }).
      state('private.projects', {
        url: '/projects',
        controller: 'ProjectsCtrl'
        templateUrl: 'templates/projects/projects.html',
        resolve: {
          projects: ['ProjectService', (ProjectService) ->
            ProjectService.all()
          ]
        }
      }).
      state('private.api_logs', {
        url: '/api_logs',
        controller: 'ApiLogsCtrl'
        templateUrl: 'templates/api_logs/api_logs.html'
      }).
      state('private.logout', {
        url: '/logout'
      })
]