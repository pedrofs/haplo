angular.module('tccless').controller 'UserViewCtrl', [
  '$scope'
  '$http'
  '$q'
  'BreadcrumbService'
  'TitleService'
  'user'
  'roles'
  ($scope, $http, $q, BreadcrumbService, TitleService, user, roles) ->
    configureView = ->
      BreadcrumbService.use 'users.view', {label: user.name || 'usuário não confirmado'}
      TitleService.setTitle user.name || 'usuário não confirmado'
      TitleService.setDescription null

    $scope.saveUser = (attribute, value) ->
      deferred = $q.defer()
      userToSend = $scope.user
      userToSend[attribute] = value

      $http.put("/users/#{user.id}.json", user: userToSend).then((response) ->
        $scope.user[attribute] = value
        deferred.resolve()
      ).catch (response) ->
        deferred.resolve(response.data.errors[attribute].pop()) if response.data.errors && response.data.errors[attribute]
      
      deferred.promise

    updateRole = (roleId) ->
      selected = $scope.roles.filter (r) ->
        r.id == roleId

      $scope.user.role = selected[0]

    $scope.error = ->
      console.log 'erro callback'
    $scope.success = (response) ->
      $scope.user.image = response.user.image

    $scope.$watch((scope) ->
        scope.user.role_id
      (newRoleId) ->
          updateRole(newRoleId)
      )

    configureView()
    $scope.user = user
    $scope.roles = roles
]