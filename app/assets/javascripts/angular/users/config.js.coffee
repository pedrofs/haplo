angular.module('tccless').config [
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider',
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.users', {
        url: '/users'
        controller: 'UsersCtrl'
        templateUrl: 'templates/users/users.html'
        resolve: {
          users: ['UserService', (UserService) ->
            UserService.all()
          ]
        }
      }).
      state('private.user_view', {
        url: '/users/:userId'
        controller: 'UserViewCtrl'
        templateUrl: 'templates/users/view.html'
      })

    BreadcrumbServiceProvider.addBreadcrumb 'users', { dependency: 'home', label: 'Usuários' }
]