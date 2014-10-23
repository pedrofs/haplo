angular.module('tccless').factory('Role', ($resource) ->
  $resource('/roles/:id.json')
)