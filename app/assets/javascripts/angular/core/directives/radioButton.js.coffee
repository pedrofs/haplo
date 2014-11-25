angular.module('tccless').directive 'radioButton', [->
  directive =
    restrict: 'A'
    require: "ngModel"
    link: (scope, element, attrs, ngModel) ->
      element.on 'click', ->
        element.parent('.btn-group').first().find('.active').removeClass('active')
        element.addClass('active')
        ngModel.$setViewValue attrs.value
        scope.$apply()

  directive
]