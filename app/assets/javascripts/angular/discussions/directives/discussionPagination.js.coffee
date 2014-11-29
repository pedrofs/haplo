angular.module('tccless').directive 'discussionPagination', [->
  directive =
    restrict: 'E'
    templateUrl: 'templates/discussions/pagination.html'
    scope:
      paginationConfig: '='
      paginationArray: '='
    link: (scope, element, attrs) ->
      element.find('button.pagination-add').click (e) ->
        scope.$apply ->
          scope.paginationConfig.limit += scope.paginationConfig.perPage
]