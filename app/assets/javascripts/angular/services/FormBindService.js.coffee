class FormBindService
  bind: (form, resourcePromisse) ->
    resourcePromisse.catch(handleError(form))

  handleError = (form) ->
    (response) ->
      if response.status == 422
        errors = response.data.errors
        bindErrorsToForm(form, errors)

  bindErrorsToForm = (form, errors) ->
    $.each(errors, (key, error) ->
      field = key.replace /\./, "__"
      message = error.pop()

      form[field].$dirty = true
      form[field].$setValidity(field, false)
      form[field].$error.backend = message
    )

@tccless.factory 'FormBindService', [ ->
  return FormBindService
]