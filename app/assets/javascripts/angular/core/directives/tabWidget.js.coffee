angular.module('tccless').directive 'tabWidget', [ ->
  directive =
    restrict: 'A'
    scope: {
      tabs: "=",
      stateParam: "@"
    }
    templateUrl: 'templates/partials/tabWidget.html'
    controller: ['$scope', '$state', ($scope, $state) ->
      $scope.stateName = $state.current.name
    ]
    link: (scope, element) ->
      if scope.stateParam
        scope.stateParam = "(#{scope.stateParam})"
      else
        scope.stateParam = ''

      element.find('.tab').each (i, element) ->
        console.log $(element)

      element.on 'click', '.tab', (e) ->
        element.find('.active').removeClass('active')
        $(this).addClass('active')
]