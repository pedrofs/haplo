angular.module('tccless').config [
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.discussions', {
        url: '/discussions',
        controller: 'DiscussionsCtrl'
        templateUrl: 'templates/discussions/index.html'
        resolve:
          discussions: ['$q', '$http', 'DiscussionData', ($q, $http, DiscussionData) ->
            deferred = $q.defer()
            $http.get("/favorite_discussions.json").then (response) ->
              DiscussionData.discussions = response.data
              deferred.resolve(response.data)

            deferred.promise
          ]
      })

    BreadcrumbServiceProvider.addBreadcrumb 'discussions', { dependency: 'home', label: 'Minhas Discussões' }
]