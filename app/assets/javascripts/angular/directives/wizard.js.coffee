angular.module('tccless').directive 'wizard', ['WizardService', (WizardService) ->
  directive =
    restrict: 'A',
    template: '',
    link: (scope, element, attrs) ->
      wizardId = '#' + attrs.wizard
      jqueryWizard = $(wizardId)
      model = attrs.wizardModel
      onSubmit = attrs.wizardSubmit

      WizardService.wizard = jqueryWizard

      jqueryWizard.on 'finished.fu.wizard', ->
        scope[onSubmit](scope[attrs.name], scope[model])

      element.onsubmit = ->
        false

  directive
]