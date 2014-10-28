angular.module('tccless').factory 'Role', ['$resource', ($resource) ->
  $resource('/roles/:id.json')
]