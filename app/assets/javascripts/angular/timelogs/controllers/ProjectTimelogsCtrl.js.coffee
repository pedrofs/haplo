angular.module('tccless').controller 'ProjectTimelogsCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'TimelogService'
  'TimelogData'
  ($scope, BreadcrumbService, TitleService, TimelogService, TimelogData) ->
    BreadcrumbService.use 'view_task.timelog'

    $scope.timelogsGroupedByDate = TimelogService.groupTimelogsByDate('dd, MMM')
]