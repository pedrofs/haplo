angular.module('tccless').factory 'Task', ['$resource', ($resource) ->
  $resource('/tasks/:id.json')
]