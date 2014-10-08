angular.module 'tccless', [
  'ngRoute',
  'ngResource',
  'ui.router',
  'ui.bootstrap',
  'LocalStorageModule',
  'angular-md5',
  'daterangepicker',
  'gantt',
  'ngColorPicker',
  'textAngular'
]

angular.module('tccless').config [
  '$routeProvider',
  '$stateProvider',
  'TabWidgetServiceProvider',
  'BreadcrumbServiceProvider'
  ($routeProvider, $stateProvider, TabWidgetServiceProvider, BreadcrumbServiceProvider) ->
    TabWidgetServiceProvider.createWidget('projects')
    TabWidgetServiceProvider.addTab('projects', {name: 'Overview', class: 'blue fa-inbox', state: 'private.project_view.overview'})

    BreadcrumbServiceProvider.addBreadcrumb 'home', { label: 'Home', icon: 'ace-icon fa fa-home home-icon' }
    BreadcrumbServiceProvider.addBreadcrumb 'users', { dependency: 'home', label: 'Usuários', link: 'private.users' }
    BreadcrumbServiceProvider.addBreadcrumb 'projects', { dependency: 'home', label: 'Projetos', link: 'private.projects' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view', { dependency: 'projects' }
    BreadcrumbServiceProvider.addBreadcrumb 'project_view.overview', { dependency: 'project_view', label: 'Overview' }

    $routeProvider.otherwise({
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/pages/welcome.html'
    })

    $stateProvider.
      state('public', {
        abstract: true,
        templateUrl: 'templates/layouts/public.html'
      }).
      state('public.start-now', {
        url: '/start-now',
        controller: 'StartNowCtrl',
        templateUrl: 'templates/pages/start-now.html'
      }).
      state('public.login', {
        url: '/login',
        controller: 'LoginCtrl',
        templateUrl: 'templates/pages/login.html'
      }).
      state('public.welcome', {
        url: '/',
        controller: 'WelcomeCtrl',
        templateUrl: 'templates/pages/welcome.html'
      }).
      state('private', {
        abstract: true,
        templateUrl: 'templates/layouts/private.html'
      }).
      state('private.users', {
        url: '/users',
        controller: 'UsersCtrl',
        templateUrl: 'templates/users/users.html',
        resolve: {
          users: ['UserService', (UserService) ->
            UserService.all()
          ]
        }
      }).
      state('private.projects', {
        url: '/projects',
        controller: 'ProjectsCtrl'
        templateUrl: 'templates/projects/projects.html',
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
          project: ['$stateParams', 'ProjectService', ($stateParams, ProjectService) ->
            ProjectService.find($stateParams.projectId)
          ]
        }
      }).
      state('private.project_view.overview', {
        url: '',
        templateUrl: 'templates/projects/overview.html',
        controller: 'ProjectOverviewCtrl'
      }).
      state('private.api_logs', {
        url: '/api_logs',
        controller: 'ApiLogsCtrl'
        templateUrl: 'templates/api_logs/api_logs.html'
      }).
      state('private.logout', {
        url: '/logout'
      })
]