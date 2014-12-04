angular.module('tccless').config [
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.timelogs', {
        url: '/timelogs'
        templateUrl: 'templates/timelogs/index.html'
        controller: 'TimelogsCtrl'
        resolve: {
          timelogs: ['$http', 'TimelogData', 'SessionService', ($http, TimelogData, SessionService) ->
            user_id_eq = SessionService.currentUser.id

            request =
              url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_not_null]=true"
              method: "GET"

            $http(request).then (response) ->
              TimelogData.timelogs = response.data
          ]
        }
      }).state('private.view_task.timelogs', {
        url: '/timelogs',
        templateUrl: 'templates/timelogs/task_timelogs.html',
        controller: 'TaskTimelogsCtrl'
        resolve:
          timelogs: ['$http', '$stateParams', 'TimelogData', ($http, $stateParams, TimelogData) ->
            $http.get("/timelogs.json?search[task_id_eq]=#{$stateParams.taskId}&search[stopped_at_not_null]=true").then (response) ->
              TimelogData.timelogs = response.data
          ]
      }).state('private.project_view.timelogs', {
        url: '/timelogs',
        templateUrl: 'templates/timelogs/project_timelogs.html',
        controller: 'ProjectTimelogsCtrl'
        resolve:
          timelogs: ['$http', '$stateParams', 'TimelogData', ($http, $stateParams, TimelogData) ->
            $http.get("/timelogs.json?search[project_id]=#{$stateParams.projectId}&search[stopped_at_not_null]=true").then (response) ->
              TimelogData.timelogs = response.data
          ]
      })

    BreadcrumbServiceProvider.addBreadcrumb 'timelogs', { dependency: 'home', label: 'Meu Timelog' }
    BreadcrumbServiceProvider.addBreadcrumb 'view_task.timelog', { dependency: 'view_task', label: 'Timelogs' }

    TabWidgetServiceProvider.addTab('tasks', {name: 'Timelog', class: 'green fa-clock-o', state: 'private.view_task.timelogs'})
    TabWidgetServiceProvider.addTab('projects', {name: 'Timelog', class: 'green fa-clock-o', state: 'private.project_view.timelogs'})
]

angular.module('tccless').run ['$http', 'ActiveTimelogData', 'SessionService', ($http, ActiveTimelogData, SessionService) ->
  return unless SessionService.currentUser

  user_id_eq = SessionService.currentUser.id
  stopped_at_null = true

  request =
    url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_null]=#{stopped_at_null}"
    method: "GET"

  $http(request).then (response) ->
    ActiveTimelogData.timelogs = response.data
]