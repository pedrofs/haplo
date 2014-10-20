angular.module('tccless').controller 'ProjectOverviewCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'project'
  ($scope, BreadcrumbService, TitleService, project) ->
    BreadcrumbService.use 'project_view.overview'
    $scope.project = project

    $scope.updateProject = ->
      console.log $scope.project

    $scope.validateProject = ->
      console.log 'validating project'
]