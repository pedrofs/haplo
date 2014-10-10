angular.module('tccless').config [
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider',
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.project_view.tasks', {
        url: '/tasks',
        templateUrl: 'templates/projects/tasks.html',
        controller: 'ProjectTasksCtrl'
      })

    TabWidgetServiceProvider.addTab('projects', {name: 'Tarefas', class: 'orange fa-tasks', state: 'private.project_view.tasks'})
    BreadcrumbServiceProvider.addBreadcrumb 'project_view.tasks', { dependency: 'project_view', label: 'Tarefas' }
]