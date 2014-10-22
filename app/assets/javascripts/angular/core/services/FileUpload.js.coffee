angular.module('tccless').service 'FileUpload', ['$http', ($http) ->
  this.uploadFileToUrlUsingName = (file, uploadUrl, name) ->
    fd = new FormData()
    fd.append name, file

    $http.put(uploadUrl, fd, {transformRequest: angular.entity, headers: {'Content-type': undefined}})

  return this
]