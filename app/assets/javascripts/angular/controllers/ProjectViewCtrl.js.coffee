angular.module('tccless').controller 'ProjectViewCtrl', [
  '$scope',
  'BreadcrumbService',
  'TitleService',
  'ProjectService'
  'project'
  ($scope, BreadcrumbService, TitleService, ProjectService, project) ->
    configureView = ->
      BreadcrumbService.reset()
      BreadcrumbService.addItem(project.name)
      TitleService.setTitle(project.name)
      TitleService.setDescription(project.description)

    configureView()
    $scope.project = project
]