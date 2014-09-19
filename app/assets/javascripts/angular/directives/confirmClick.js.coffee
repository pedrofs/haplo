@tccless.directive 'confirmClick', [ ->
  directive =
    link: (scope, element, attr) ->
      msg = attr.confirmClickMessage || "Are you sure?"
      clickAction = attr.confirmClickAction

      element.bind 'click', (event) ->
        if window.confirm(msg)
            scope.$eval(clickAction)

  directive
]