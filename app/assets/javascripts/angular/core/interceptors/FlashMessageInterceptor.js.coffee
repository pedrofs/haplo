angular.module('tccless').factory 'FlashMessageInterceptor', [->
  obj =
    response: (response) ->
      if typeof response.data is 'object' and response.data.flash
        growlOptions =
          type: response.data.type
          allow_dismiss: false
          placement:
            from: "top"
            align: "center"
          animate:
            enter: 'animated fadeInDown'
            exit: 'animated fadeOutUp'

        $.growl(response.data.flash, growlOptions)

      response

  return obj
]

angular.module('tccless').config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push 'FlashMessageInterceptor'
]