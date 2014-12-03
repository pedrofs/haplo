angular.module('tccless').config [
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->

]

angular.module('tccless').run ['$http', 'ActiveTimelogData', 'SessionService', ($http, ActiveTimelogData, SessionService) ->
  user_id_eq = SessionService.currentUser.id
  stopped_at_null = true

  request =
    url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_null]=#{stopped_at_null}"
    method: "GET"

  $http(request).then (response) ->
    ActiveTimelogData.timelogs = response.data
]