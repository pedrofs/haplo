angular.module('tccless').controller 'ProjectOverviewCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'project'
  ($scope, BreadcrumbService, TitleService, project) ->
    BreadcrumbService.use 'project_view.overview'
]