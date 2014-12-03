angular.module('tccless').directive 'loggedTimeForTimelog', ['TimelogData', (TimelogData) ->
  restrict: 'A'
  templateUrl: 'templates/timelogs/logged_time_for_task.html'
  scope:
    timelog: '='
  link: (scope, element, attr) ->
    loggedTime = new Date(scope.timelog.stopped_at).getTime() - new Date(scope.timelog.started_at).getTime()

    DAY = 1000 * 60 * 60  * 24
    HOUR = 1000 * 60 * 60
    MINUTE = 1000 * 60

    scope.dayPassed = Math.floor(loggedTime / DAY)
    scope.hourPassed = Math.floor((loggedTime / HOUR) % 60)
    scope.minutePassed = Math.floor((loggedTime / MINUTE) % 60)
]