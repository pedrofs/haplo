angular.module('tccless').config [
  '$stateProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.roles', {
        url: '/roles'
        templateUrl: 'templates/roles/index.html'
        controller: 'RolesCtrl'
        resolve: {
          tasks: ['RoleService', 'RoleData', (RoleService, RoleData) ->
            RoleService.all().then (response) ->
              RoleData.roles = response.data
          ]
        }
    }).state('private.view_role', {
      url: '/roles/:roleId'
      templateUrl: 'templates/roles/view.html'
      controller: 'ViewRoleCtrl'
      resolve:
        role: ['$stateParams', 'RoleService', '$q', ($stateParams, RoleService, $q) ->
          deferred = $q.defer()
          RoleService.find($stateParams.roleId).then (response) ->
            deferred.resolve response.data
          deferred.promise
        ]
      })

    BreadcrumbServiceProvider.addBreadcrumb 'roles', { dependency: 'home', label: 'Roles de usuário' }
    BreadcrumbServiceProvider.addBreadcrumb 'roles.view', { dependency: 'roles' }
]