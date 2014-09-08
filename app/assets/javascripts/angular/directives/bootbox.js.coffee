@tccless.directive 'bootbox', ['$state', ($state) ->
  directive =
    restrict: 'A',
    template: '',
    link: (scope, element, attrs) ->
      template = '#' + attrs.template

      config =
        title: attrs.title,
        message: $(template).html(),
        closeButton: false,
        onEscape: (e) ->
          $state.go('private.users')
          return false
        ,buttons: {}

      bootbox.dialog config

  directive
]