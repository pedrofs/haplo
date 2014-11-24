angular.module('tccless').directive 'fileInput', ['FileUpload', (FileUpload) ->
  directive =
    restrict: 'A'
    scope: {
      success: '&'
      error: '&'
    }
    link: (scope, element, attrs) ->
      input = $(attrs.fileInput)
      action = attrs.submitUrl

      if attrs.fileInputCondition == undefined or attrs.fileInputCondition == 'true'
        element.bind 'click', (e) ->
          input.click()

        input.bind 'change', (e) ->
          file = e.target.files[0]
          promise = FileUpload.uploadFileToUrlUsingName file, action, input.attr('name')

          promise.success (response) ->
            env =
              response: response
            scope.success(env)

          promise.error (response) ->
            env =
              response: response
            scope.error(env)
]