angular.module('tccless').directive 'loggedTimeForTask', ['TimelogData', (TimelogData) ->
  restrict: 'A'
  templateUrl: 'templates/timelogs/logged_time_for_task.html'
  scope:
    task: '='
  link: (scope, element, attr) ->
    timelogs = TimelogData.timelogs.filter (t) -> t.task.id == scope.task.id

    loggedTime = 0

    for t in timelogs
      loggedTime += new Date(t.stopped_at).getTime() - new Date(t.started_at).getTime()

    DAY = 1000 * 60 * 60 * 24
    HOUR = 1000 * 60 * 60
    MINUTE = 1000 * 60

    scope.dayPassed = Math.floor(loggedTime / DAY)
    scope.hourPassed = Math.floor((loggedTime / HOUR) % 60)
    scope.minutePassed = Math.floor((loggedTime / MINUTE) % 60)
]