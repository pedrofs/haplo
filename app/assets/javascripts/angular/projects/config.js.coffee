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
          ],
          favoriteProjects: ['$q', '$http', 'FavoriteProjectData', ($q, $http, FavoriteProjectData) ->
            deferred = $q.defer()
            $http.get("/favorite_projects.json").then (response) ->
              FavoriteProjectData.favoriteProjects = response.data
              deferred.resolve(response.data)

            deferred.promise
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
        resolve:
          taskPerStatus: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            $http.get("/charts/task/donut_per_status/#{$stateParams.projectId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise
          ]
          taskPerPriority: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            $http.get("/charts/task/donut_per_priority/#{$stateParams.projectId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise
          ]
          timelogGraphData: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            $http.get("/charts/timelog/project_timelog_by_task/#{$stateParams.projectId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise 
          ]
          timelogReportData: ['$q', '$http', '$stateParams', ($q, $http, $stateParams) ->
            deferred = $q.defer()
            promise = $http.get("/charts/timelog/project_timelog_general_info/#{$stateParams.projectId}.json").then (response) ->
              deferred.resolve response.data
            deferred.promise
          ]
      })

    BreadcrumbServiceProvider.addBreadcrumb 'projects', { dependency: 'home', label: 'Projetos' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view', { dependency: 'projects' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view.overview', { dependency: 'project_view', label: 'Overview' }

    TabWidgetServiceProvider.createWidget('projects')
    TabWidgetServiceProvider.addTab('projects', {name: 'Overview', class: 'blue fa-inbox', state: 'private.project_view.overview'})
]