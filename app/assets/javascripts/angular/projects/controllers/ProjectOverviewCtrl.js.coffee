angular.module('tccless').controller 'ProjectOverviewCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'project'
  '$q'
  '$http'
  'taskPieChart'
  ($scope, BreadcrumbService, TitleService, project, $q, $http, taskPieChart) ->
    watchTitleAttributes = ->
      $scope.$watch((scope) ->
        scope.project.name
      (newName) ->
          TitleService.setTitle(newName)
      )

      $scope.$watch((scope) ->
        scope.project.description
      (newDescription) ->
          TitleService.setDescription(newDescription)
      )

    $scope.saveProject = (attribute, value) ->
      deferred = $q.defer()
      projectToSend = $scope.project
      projectToSend[attribute] = value

      $http.put("/projects/#{project.id}.json", project: projectToSend).then((response) ->
        $scope.project[attribute] = value
        deferred.resolve()
      ).catch (response) ->
        deferred.resolve(response.data.errors[attribute].pop()) if response.data.errors && response.data.errors[attribute]
      
      deferred.promise

    $scope.error = ->
      console.log 'erro callback'
    $scope.success = (response) ->
      $scope.project.image = response.project.image

    BreadcrumbService.use 'project_view.overview'
    $scope.project = project
    watchTitleAttributes()
    $scope.taskPieChart = taskPieChart
]