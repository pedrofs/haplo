angular.module('tccless').config [
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider',
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.api_logs', {
        url: '/api_logs',
        controller: 'ApiLogsCtrl'
        templateUrl: 'templates/api_logs/api_logs.html'
      })

    BreadcrumbServiceProvider.addBreadcrumb 'api_logs', { dependency: 'home', label: 'API Logs', link: 'private.api_logs' }
]