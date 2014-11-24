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
    })

    TabWidgetServiceProvider.addTab('projects', {name: 'Tarefas', class: 'orange fa-tasks', state: 'private.project_view.tasks'})

    BreadcrumbServiceProvider.addBreadcrumb 'project_view.tasks', { dependency: 'project_view', label: 'Tarefas' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses', { dependency: 'home', label: 'Status de tarefa' }
    BreadcrumbServiceProvider.addBreadcrumb 'task_statuses.view', { dependency: 'task_statuses' }
]