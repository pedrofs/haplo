angular.module('tccless').directive 'timelogButtons', ['$http', 'ActiveTimelogData', ($http, ActiveTimelogData) ->
  restrict: 'A'
  templateUrl: 'templates/timelogs/buttons.html'
  scope:
    task: '='
  link: (scope, element, attr) ->
    activeTimelog = ActiveTimelogData.timelogs.filter (t) -> t.task.id == scope.task.id
    scope.actived = false
    
    if activeTimelog.length > 0
      activeTimelog = activeTimelog.pop()
      scope.actived = true
      scope.startedAt = new Date(activeTimelog.started_at).getTime()

    element.find('.start-button').click ->
      $http.post("/timelogs/toggle/#{scope.task.id}.json").then (response) ->
        scope.actived = true
        ActiveTimelogData.add response.data
        scope.startedAt = new Date(response.data.started_at)

    element.find('.stop-button').click ->
      $http.post("/timelogs/toggle/#{scope.task.id}.json").then (response) ->
        ActiveTimelogData.remove response.data.id
        scope.actived = false
]