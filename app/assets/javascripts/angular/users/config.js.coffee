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
        resolve:
          user: ['$http', '$q', '$stateParams', ($http, $q, $stateParams) ->
            deferred = $q.defer()
            $http.get("/users/#{$stateParams.userId}.json").then (response) -> deferred.resolve(response.data)
            deferred.promise
          ]
      })

    BreadcrumbServiceProvider.addBreadcrumb 'users', { dependency: 'home', label: 'Usuários' }
    BreadcrumbServiceProvider.addBreadcrumb 'users.view', { dependency: 'users' }
]