@tccless.directive 'title', ['TitleService', (TitleService) ->
  directive =
    restrict: 'A',
    templateUrl: 'templates/title.html',
    link: (scope, element) ->
      scope.titleService = TitleService

  directive
]