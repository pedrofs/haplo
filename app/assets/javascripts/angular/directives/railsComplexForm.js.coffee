@tccless.directive 'railsComplexForm', [ ->
  directive =
    restrict: 'A',
    templateUrl: 'templates/rails_complex_form.html'
    scope: {
      rootResource: '=',
      childrenAttribute: '@',
      formTemplate: '@',
      validateChild: '&',
      changedCallback: '&',
      childFactory: '&',
      removeChildSetter: '&',
      extraData: '='
    }
    controller: ['$scope', ($scope) ->
      removeChild = (index) ->
        return if not $scope.rootResource[$scope.childrenAttribute][index]
        child = $scope.rootResource[$scope.childrenAttribute][index]
        $scope.rootResource[$scope.childrenAttribute][index]['_destroy'] = 1
        $scope.changedCallback({ child: child })

      $scope.removeChildSetter({ fn: removeChild })

      $scope.addChild = (child) ->
        $scope.rootResource[$scope.childrenAttribute] = [] if not $scope.rootResource[$scope.childrenAttribute]

        return unless $scope.validateChild {child: child}

        preparedChild = $scope.childFactory { child: child }
        $scope.rootResource[$scope.childrenAttribute].push preparedChild

        $scope.changedCallback({ child: child })

        $('.rails-complex-form-reset').val('')
    ]

  directive
]