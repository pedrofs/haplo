angular.module('tccless').controller 'UserViewCtrl', [
  '$scope'
  '$modal'
  'BreadcrumbService'
  'TitleService'
  'user'
  ($scope, $modal, BreadcrumbService, TitleService, user) ->
    configureView = ->
      BreadcrumbService.use 'users.view', {label: user.name}
      TitleService.setTitle user.name
      TitleService.setDescription null

    configureView()
    $scope.user = user
]