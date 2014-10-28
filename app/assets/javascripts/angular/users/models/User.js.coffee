angular.module('tccless').factory 'User', ['$resource', ($resource) ->
  return $resource('/users/:id.json')
]