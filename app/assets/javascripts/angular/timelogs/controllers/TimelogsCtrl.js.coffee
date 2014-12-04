angular.module('tccless').controller 'TimelogsCtrl', [
  '$scope'
  '$http'
  '$filter'
  'BreadcrumbService'
  'TitleService'
  'TimelogData'
  'ActiveTimelogData'
  'TimelogService'
  ($scope, $http, $filter, BreadcrumbService, TitleService, TimelogData, ActiveTimelogData, TimelogService) ->
    configureView = ->
      BreadcrumbService.use 'timelogs'
      TitleService.setTitle 'Meus Timelog'
      TitleService.setDescription 'A lista de seus Timelogs.'

    reDraw = ->
      $scope.timelogsGroupedByDate = TimelogService.groupTimelogsByDate('dd, MMM')

    $scope.removeTimelog = (id) ->
      $http.delete("/timelogs/#{id}.json").then ->
        TimelogData.remove id

    configureView()

    $scope.TimelogData = TimelogData
    $scope.timelogsGroupedByDate = TimelogService.groupTimelogsByDate('dd, MMM')
    $scope.ActiveTimelogData = ActiveTimelogData

    $scope.$watch 'TimelogData', reDraw, true
]