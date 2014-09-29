angular.module('tccless').directive 'railsComplexFormAddButton', ['$parse', ($parse) ->
  directive =
    restrict: 'A',
    link: (scope, element, attrs) ->
      element.on 'click', (e) ->
        child = $parse(attrs.childResource)(scope)

        scope.addChild(child)

  directive
]