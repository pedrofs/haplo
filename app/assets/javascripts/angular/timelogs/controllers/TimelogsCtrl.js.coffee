angular.module('tccless').controller 'TimelogsCtrl', [
  '$scope'
  '$http'
  '$filter'
  'BreadcrumbService'
  'TitleService'
  'TimelogData'
  'ActiveTimelogData'
  ($scope, $http, $filter, BreadcrumbService, TitleService, TimelogData, ActiveTimelogData) ->
    configureView = ->
      BreadcrumbService.use 'timelogs'
      TitleService.setTitle 'Meus Timelog'
      TitleService.setDescription 'A lista de seus Timelogs.'

    reDraw = ->
      $scope.timelogsGroupedByDate = groupTimelogsByDate('dd, MMM')

    groupTimelogsByDate = (dateFormat) ->
      grouped = {}

      for timelog in TimelogData.timelogs
        date = $filter('date')(timelog.stopped_at, dateFormat)
        grouped[date] = [] unless grouped[date]?
        grouped[date].push timelog

      grouped

    $scope.removeTimelog = (id) ->
      $http.delete("/timelogs/#{id}.json").then ->
        TimelogData.remove id

    configureView()

    $scope.TimelogData = TimelogData
    $scope.timelogsGroupedByDate = groupTimelogsByDate('dd, MMM')
    $scope.ActiveTimelogData = ActiveTimelogData

    $scope.$watch 'TimelogData', reDraw, true
]