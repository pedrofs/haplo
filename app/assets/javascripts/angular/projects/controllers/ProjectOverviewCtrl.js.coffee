angular.module('tccless').controller 'ProjectOverviewCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'project'
  '$q'
  '$http'
  'taskPieChart'
  'taskLineChart'
  ($scope, BreadcrumbService, TitleService, project, $q, $http, taskPieChart, taskLineChart) ->
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
    $scope.taskLineChart = taskLineChart

    data = [['2008-09-30 4:00PM',4], ['2008-10-30 4:00PM',6.5], ['2008-11-30 4:00PM',5.7], ['2008-12-30 4:00PM',9], ['2009-01-30 4:00PM',8.2]]
    data2 = [['2008-09-30 4:00PM',4], ['2008-10-30 4:00PM',6.5], ['2008-11-30 4:00PM',5.7], ['2008-12-30 4:00PM',9], ['2009-01-30 4:00PM',8.2]]

    $scope.data = [data,data2]
]