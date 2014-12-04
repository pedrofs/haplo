angular.module('tccless').config [
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider',
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.project_view.tasks', {
        url: '/tasks'
        templateUrl: 'templates/projects/tasks.html'
        controller: 'ProjectTasksCtrl'
        resolve: {
          tasks: ['TaskService', 'TaskData', '$stateParams', (TaskService, TaskData, $stateParams) ->
            TaskService.all($stateParams.projectId).then (response) ->
              TaskData.count = response.data.count
              TaskData.tasks = response.data.tasks
          ]
          timelog: ['TimelogData', '$http', '$stateParams', (TimelogData, $http, $stateParams) ->
            $http.get("/timelogs.json?search[project_id]=#{$stateParams.projectId}").then (response) ->
              TimelogData.timelogs = response.data
          ]
        }
      }).state('private.tasks', {
        url: '/tasks'
        templateUrl: 'templates/tasks/index.html'
        controller: 'TasksCtrl'
        resolve: {
          tasks: ['$http', 'TaskData', 'SessionService', ($http, TaskData, SessionService) ->
            $http.get("/users/#{SessionService.currentUser.id}/tasks.json").then (response) ->
              TaskData.count = response.data.count
              TaskData.tasks = response.data.tasks
          ]
          timelogs: ['$http', 'TimelogData', 'SessionService', ($http, TimelogData, SessionService) ->
            user_id_eq = SessionService.currentUser.id
            stopped_at_not_null = true

            request =
              url: "/timelogs.json?search[user_id_eq]=#{user_id_eq}&search[stopped_at_not_null]=#{stopped_at_not_null}"
              method: "GET"

            $http(request).then (response) ->
              TimelogData.timelogs = response.data
          ]
        }
      }).state('private.view_task', {
        url: '/tasks/:taskId'
        templateUrl: 'templates/tasks/view.html'
        abstract: true
        controller: 'ViewTaskCtrl'
        resolve:
          task: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            $http.get("/tasks/#{$stateParams.taskId}.json").then (response) ->
              deferred.resolve response.data

            deferred.promise
          ]
      }).state('private.view_task.overview', {
        url: '',
        templateUrl: 'templates/tasks/overview.html',
        controller: 'OverviewTaskCtrl'
        resolve:
          users: ['$q', '$http', ($q, $http) ->
            deferred = $q.defer()
            $http.get("/users.json").then (response) ->
              deferred.resolve response.data
            deferred.promise
          ]
          timelogGraphData: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            $http.get("/charts/timelog/task_timelog_by_user_and_day/#{$stateParams.taskId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise 
          ]
          timelogReportData: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            promise = $http.get("/charts/timelog/task_timelog_general_info/#{$stateParams.taskId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise
          ]
          timelog: ['$http', 'TimelogData', '$stateParams', ($http, TimelogData, $stateParams) ->
            $http.get("/timelogs.json?search[task_id_eq]=#{$stateParams.taskId}.json").then (response) ->
              TimelogData.timelogs = response.data
          ]
      })

    TabWidgetServiceProvider.createWidget('tasks')
    TabWidgetServiceProvider.addTab('tasks', {name: 'Overview', class: 'blue fa-inbox', state: 'private.view_task.overview'})

    TabWidgetServiceProvider.addTab('projects', {name: 'Tarefas', class: 'brown fa-tasks', state: 'private.project_view.tasks'})

    BreadcrumbServiceProvider.addBreadcrumb 'tasks', { dependency: 'home', label: 'Minhas Tarefas' }

    BreadcrumbServiceProvider.addBreadcrumb 'view_task', { dependency: 'home' }
    BreadcrumbServiceProvider.addBreadcrumb 'view_task.overview', { dependency: 'view_task', label: 'Overview' }

    BreadcrumbServiceProvider.addBreadcrumb 'project_view.overview', { dependency: 'project_view', label: 'Overview' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view.tasks', { dependency: 'project_view', label: 'Tarefas' }
]