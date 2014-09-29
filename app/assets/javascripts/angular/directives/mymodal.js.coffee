angular.module('tccless').directive 'mymodal', ['$modal', ($modal) ->
  directive =
    restrict: 'A',
    template: '',
    link: (scope, element, attrs) ->
      template = attrs.modaltemplate
      controller = attrs.modalctrl
      size = attrs.modalsize

      config =
        templateUrl: template,
        backdrop: false,
        keyboard: false,
        controller: controller
        size: size

      element.on 'click', ->
        $modal.open config

  directive
]