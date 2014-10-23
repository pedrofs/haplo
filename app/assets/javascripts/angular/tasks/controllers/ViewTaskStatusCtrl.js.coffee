angular.module('tccless').controller 'ViewTaskStatusCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'status'
  '$q'
  '$http'
  ($scope, BreadcrumbService, TitleService, statusResponse, $q, $http) ->
    configureView = ->
      BreadcrumbService.use 'task_statuses.view', {label: $scope.status.name}
      TitleService.setTitle "Editar status da tarefa: #{$scope.status.name}"

    $scope.saveStatus = (attribute, value) ->
      deferred = $q.defer()
      statusToSend = $scope.status
      statusToSend[attribute] = value

      $http.put("/task_statuses/#{$scope.status.id}.json", task_status: statusToSend).then((response) ->
        $scope.status[attribute] = value
        deferred.resolve()
      ).catch (response) ->
        deferred.resolve(response.data.errors[attribute].pop()) if response.data.errors && response.data.errors[attribute]
      
      deferred.promise

    $scope.status = statusResponse.data
    configureView()
]