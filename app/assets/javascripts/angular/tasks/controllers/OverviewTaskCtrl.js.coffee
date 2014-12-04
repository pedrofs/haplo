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

    updatePriority = (priorityId) ->
      selected = $scope.priorities.filter (u) ->
        u.id == priorityId

      $scope.task.priority_name = selected[0].name

    $scope.changeStatus = (status) ->
      $http.put("/tasks/#{task.id}/change_status/#{status}.json").then (response) ->
        $scope.task.status = response.data.task.status
        $scope.task.status_name = response.data.task.status_name

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
        updateAssigned(newId)
      )

    $scope.$watch((scope) ->
        scope.task.priority
      (newId) ->
        updatePriority(newId)
      )

    $scope.timelogGraphOptions = taskTimelogByUserAndDay
    $scope.timelogGraphData = timelogGraphData
    $scope.timelogReportData = timelogReportData
    $scope.priorities = [
      {id: 0, name: 'Baixa'}
      {id: 1, name: 'Média'}
      {id: 2, name: 'Alta'}
    ]
]