angular.module 'tccless', [
  'ngRoute'
  'ngResource'
  'ui.router'
  'ui.bootstrap'
  'ui.select'
  'LocalStorageModule'
  'angular-md5'
  'daterangepicker'
  'gantt'
  'ngColorPicker'
  'textAngular'
  'xeditable'
]

angular.module('tccless').config [
  '$routeProvider'
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($routeProvider, $stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->

    BreadcrumbServiceProvider.addBreadcrumb 'home', { label: 'Home', icon: 'ace-icon fa fa-home home-icon' }

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
      state('private.logout', {
        url: '/logout'
      })
]

angular.module('tccless').run [ 'editableOptions', (editableOptions) ->
  editableOptions.theme = 'bs3'
]