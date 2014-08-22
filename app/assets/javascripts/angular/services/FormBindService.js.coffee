class FormBindService
  bind: (form, resourcePromisse) ->
    resourcePromisse.catch(this.handleError(form))

  handleError: (form) ->
    self = this

    return (response) ->
      if response.status == 422
        errors = response.data.errors
        self.bindErrorsToForm(form, errors)

  bindErrorsToForm: (form, errors) ->
    $.each(errors, (key, error) ->
      field = key.replace /\./, "__"
      message = error.pop()

      console.log(form[field])

      form[field].$dirty = true
      form[field].$setValidity(field, false)
      form[field].$error.backend = message
    )

@tccless.factory 'FormBindService', [ ->
  return FormBindService
]