angular.module('tccless').directive 'breadcrumb', ['BreadcrumbService', (BreadcrumbService) ->
  directive =
    restrict: 'A',
    templateUrl: 'templates/partials/breadcrumb.html',
    scope: {}
    link: (scope, element) ->
      scope.breadcrumb = BreadcrumbService

  directive
]