@tccless.directive 'pagetitle', ['TitleService', (TitleService) ->
  directive =
    restrict: 'E',
    replace: true,
    templateUrl: 'templates/partials/pagetitle.html',
    link: (scope, element) ->
      scope.titleService = TitleService

  directive
]