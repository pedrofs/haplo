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
      BreadcrumbService.use 'users.view', {label: user.name}
      TitleService.setTitle user.name
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

    $scope.error = ->
      console.log 'erro callback'
    $scope.success = (user) ->
      $scope.user.image = user.image

    configureView()
    $scope.user = user
    $scope.roles = roles
]