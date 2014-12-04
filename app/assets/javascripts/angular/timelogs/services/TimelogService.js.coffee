angular.module('tccless').factory 'TimelogService', ['$filter', 'TimelogData', ($filter, TimelogData) ->
  data =
    groupTimelogsByDate: (dateFormat) ->
      grouped = {}

      for timelog in TimelogData.timelogs
        date = $filter('date')(timelog.stopped_at, dateFormat)
        grouped[date] = [] unless grouped[date]?
        grouped[date].push timelog

      grouped

  data
]