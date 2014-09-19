@tccless.factory 'WizardService', ->
  obj =
    wizard: null
    reset: ->
      this.wizard.wizard 'selectedItem', {step: 1}

  obj