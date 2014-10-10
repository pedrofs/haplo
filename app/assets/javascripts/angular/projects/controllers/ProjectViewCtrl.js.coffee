angular.module('tccless').controller 'ProjectViewCtrl', [
  '$scope',
  'BreadcrumbService',
  'TitleService',
  'ProjectService'
  'project',
  'TabWidgetService'
  ($scope, BreadcrumbService, TitleService, ProjectService, project, TabWidgetService) ->
    configureView = ->
      TitleService.setTitle(project.name)
      TitleService.setDescription(project.description)
      BreadcrumbService.use('project_view', {label: project.name})

    configureView()

    $scope.project = project
    $scope.tabs = TabWidgetService.getTabs('projects')

    stateParam =
      projectId: project.id
    $scope.tabStateParam = JSON.stringify stateParam
]