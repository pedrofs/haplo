angular.module('tccless').controller 'ViewRoleCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'role'
  '$q'
  '$http'
  ($scope, BreadcrumbService, TitleService, role, $q, $http) ->
    configureView = ->
      BreadcrumbService.use 'roles.view', {label: $scope.role.name}
      TitleService.setTitle "Editar role de usuário: #{$scope.role.name}"

    $scope.saveRole = (attribute, value) ->
      deferred = $q.defer()
      roleToSend = $scope.role
      roleToSend[attribute] = value

      $http.put("/roles/#{$scope.role.id}.json", role: roleToSend).then((response) ->
        $scope.role[attribute] = value
        deferred.resolve()
      ).catch (response) ->
        deferred.resolve(response.data.errors[attribute].pop()) if response.data.errors && response.data.errors[attribute]
      
      deferred.promise

    $scope.role = role
    configureView()
]