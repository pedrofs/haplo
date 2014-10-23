angular.module('tccless').controller 'RolesCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'RoleService'
  'RoleData'
  ($scope, BreadcrumbService, TitleService, RoleService, RoleData) ->
    $scope.removeRole = (id) ->
      RoleService.remove(id).then ->
        RoleData.remove id

    configureView = ->
      BreadcrumbService.use 'roles'
      TitleService.setTitle 'Roles de usuário'
      TitleService.setDescription 'Gerencie as funções de usuário'

    configureView()

    $scope.RoleData = RoleData
]