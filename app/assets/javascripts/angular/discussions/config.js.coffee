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
        }).
        state('private.project_view.discussions', {
          url: '/discussions'
          templateUrl: 'templates/discussions/discussions.html'
          controller: 'ObjectDiscussionsCtrl'
          resolve: {
            discussions: ['$http', '$stateParams', 'DiscussionData', ($http, $stateParams, DiscussionData) ->
              $http.get("/discussions.json?targetable_id=#{$stateParams.projectId}&targetable_type=Project").then (response) ->
                DiscussionData.discussions = response.data
            ]
          }
        }).
        state('private.view_task.discussions', {
          url: '/discussions'
          templateUrl: 'templates/discussions/discussions.html'
          controller: 'ObjectDiscussionsCtrl'
          resolve: {
            discussions: ['$http', '$stateParams', 'DiscussionData', ($http, $stateParams, DiscussionData) ->
              $http.get("/discussions.json?targetable_id=#{$stateParams.taskId}&targetable_type=Task").then (response) ->
                DiscussionData.discussions = response.data
            ]
          }
        })

    BreadcrumbServiceProvider.addBreadcrumb 'discussions', { dependency: 'home', label: 'Minhas Discussões' }

    TabWidgetServiceProvider.addTab('projects', {name: 'Discussões', class: 'orange fa-weixin', state: 'private.project_view.discussions'})
    TabWidgetServiceProvider.addTab('tasks', {name: 'Discussões', class: 'orange fa-weixin', state: 'private.view_task.discussions'})
]