angular.module('tccless').config [
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.timelogs', {
        url: '/timelogs'
        templateUrl: 'templates/timelogs/index.html'
        controller: 'TimelogsCtrl'
        resolve: {
          timelogs: ['$http', 'TimelogData', 'SessionService', ($http, TimelogData, SessionService) ->
            user_id_eq = SessionService.currentUser.id
            stopped_at_not_null = true

            request =
              url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_not_null]=#{stopped_at_not_null}"
              method: "GET"

            $http(request).then (response) ->
              TimelogData.timelogs = response.data
          ]
        }
      })

    BreadcrumbServiceProvider.addBreadcrumb 'timelogs', { dependency: 'home', label: 'Meu Timelog' }
]

angular.module('tccless').run ['$http', 'ActiveTimelogData', 'SessionService', ($http, ActiveTimelogData, SessionService) ->
  return unless SessionService.currentUser

  user_id_eq = SessionService.currentUser.id
  stopped_at_null = true

  request =
    url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_null]=#{stopped_at_null}"
    method: "GET"

  $http(request).then (response) ->
    ActiveTimelogData.timelogs = response.data
]