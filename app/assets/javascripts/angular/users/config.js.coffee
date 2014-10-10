angular.module('tccless').config [
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider',
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state 'private.users', {
        url: '/users',
        controller: 'UsersCtrl',
        templateUrl: 'templates/users/users.html',
        resolve: {
          users: ['UserService', (UserService) ->
            UserService.all()
          ]
        }
      }

    BreadcrumbServiceProvider.addBreadcrumb 'users', { dependency: 'home', label: 'Usuários', link: 'private.users' }
]