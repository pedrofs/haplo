@tccless = angular.module('tccless', ['ngRoute', 'ngResource'])

@tccless.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/start-now', {
      templateUrl: 'templates/start-now.html',
      controller: 'StartNowCtrl'
    }).
    when('/login', {
      templateUrl: 'templates/login.html',
      controller: 'LoginCtrl'
    }).
    otherwise({
      templateUrl: 'templates/welcome.html',
      controller: 'WelcomeCtrl'
    })
])