angular.module('tccless').config [
  '$stateProvider'
  'TabWidgetServiceProvider'
  'BreadcrumbServiceProvider'
  ($stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    $stateProvider.
      state('private.projects', {
        url: '/projects',
        controller: 'ProjectsCtrl'
        templateUrl: 'templates/projects/projects.html'
        resolve: {
          projects: ['ProjectService', (ProjectService) ->
            ProjectService.all()
          ]
        }
      }).
      state('private.project_view', {
        url: '/projects/:projectId',
        abstract: true,
        templateUrl: 'templates/projects/view.html',
        controller: 'ProjectViewCtrl'
        resolve: {
          project: ['$stateParams', 'ProjectService', 'ProjectData', ($stateParams, ProjectService, ProjectData) ->
            ProjectService.find($stateParams.projectId).then (project) ->
              ProjectData.currentProject = project
          ]
        }
      }).
      state('private.project_view.overview', {
        url: '',
        templateUrl: 'templates/projects/overview.html',
        controller: 'ProjectOverviewCtrl'
      })

    BreadcrumbServiceProvider.addBreadcrumb 'projects', { dependency: 'home', label: 'Projetos' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view', { dependency: 'projects' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view.overview', { dependency: 'project_view', label: 'Overview' }

    TabWidgetServiceProvider.createWidget('projects')
    TabWidgetServiceProvider.addTab('projects', {name: 'Overview', class: 'blue fa-inbox', state: 'private.project_view.overview'})
]