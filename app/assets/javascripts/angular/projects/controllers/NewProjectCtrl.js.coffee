angular.module('tccless').controller 'NewProjectCtrl', [
  '$scope'
  '$http'
  '$filter'
  'ProjectService'
  'FormBindService'
  'Project'
  ($scope, $http, $filter, ProjectService, FormBindService, Project) ->
    $scope.project = {name: null}

    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createProject = (form) ->
      formBind = new FormBindService()

      project = new Project({project: $scope.project})
      creationPromisse = project.$save()

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        ProjectService.add(response.project)
        $scope.$dismiss('created')
]
