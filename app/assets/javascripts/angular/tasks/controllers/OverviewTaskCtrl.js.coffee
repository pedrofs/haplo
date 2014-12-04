angular.module('tccless').controller 'OverviewTaskCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'task'
  '$q'
  '$http'
  'users'
  'taskTimelogByUserAndDay'
  'timelogGraphData'
  'timelogReportData'
  ($scope, BreadcrumbService, TitleService, task, $q, $http, users, taskTimelogByUserAndDay, timelogGraphData, timelogReportData) ->
    BreadcrumbService.use 'view_task.overview'
    $scope.task = task
    $scope.users = users

    updateAssigned = (assignedId) ->
      selected = $scope.users.filter (u) ->
        u.id == assignedId

      $scope.task.assigned = selected[0]

    $scope.saveTask = (attribute, value) ->
      deferred = $q.defer()
      taskToSend = $scope.task
      taskToSend[attribute] = value

      $http.put("/tasks/#{task.id}.json", task: taskToSend).then((response) ->
        $scope.task[attribute] = value
        deferred.resolve()
      ).catch (response) ->
        deferred.resolve(response.data.errors[attribute].pop()) if response.data.errors && response.data.errors[attribute]
      
      deferred.promise

    $scope.$watch((scope) ->
        scope.task.assigned_id
      (newId) ->
        console.log newId
      )

    $scope.timelogGraphOptions = taskTimelogByUserAndDay
    $scope.timelogGraphData = timelogGraphData
    $scope.timelogReportData = timelogReportData
    console.log timelogReportData
]