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
    })

    TabWidgetServiceProvider.addTab('projects', {name: 'Tarefas', class: 'orange fa-tasks', state: 'private.project_view.tasks'})

    BreadcrumbServiceProvider.addBreadcrumb 'tasks', { dependency: 'home', label: 'Minhas Tarefas' }

    BreadcrumbServiceProvider.addBreadcrumb 'project_view.tasks', { dependency: 'project_view', label: 'Tarefas' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses', { dependency: 'home', label: 'Status de tarefa' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses.view', { dependency: 'task_statuses' }
]