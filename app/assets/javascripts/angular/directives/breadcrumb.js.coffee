@tccless.directive 'breadcrumb', ['BreadcrumbService', (BreadcrumbService) ->
  directive =
    restrict: 'A',
    templateUrl: 'templates/breadcrumb.html',
    link: (scope, element) ->
      scope.breadcrumb = BreadcrumbService

  directive
]