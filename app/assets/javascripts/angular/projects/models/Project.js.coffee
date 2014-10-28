angular.module('tccless').factory 'Project', ['$resource', ($resource) ->
  return $resource('/projects/:id.json')
]