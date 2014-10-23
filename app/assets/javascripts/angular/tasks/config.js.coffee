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
    }).state('private.task_statuses', {
      url: '/task_statuses'
      templateUrl: 'templates/task_statuses/index.html'
      controller: 'TaskStatusesCtrl'
      resolve:
        taskStatuses: ['TaskStatusService','TaskStatusData', (TaskStatusService, TaskStatusData) ->
          TaskStatusService.all().then (response) ->
            TaskStatusData.count = response.data.count
            TaskStatusData.taskStatuses = response.data
        ]
    }).state('private.view_task_statuses', {
      url: '/task_statuses/:taskStatusId'
      templateUrl: 'templates/task_statuses/view.html'
      controller: 'ViewTaskStatusCtrl'
      resolve:
        status: ['$stateParams', 'TaskStatusService', ($stateParams, TaskStatusService) ->
          TaskStatusService.find($stateParams.taskStatusId)
        ]
      })

    TabWidgetServiceProvider.addTab('projects', {name: 'Tarefas', class: 'orange fa-tasks', state: 'private.project_view.tasks'})

    BreadcrumbServiceProvider.addBreadcrumb 'project_view.tasks', { dependency: 'project_view', label: 'Tarefas' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses', { dependency: 'home', label: 'Status de tarefa' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses.view', { dependency: 'task_statuses' }
]