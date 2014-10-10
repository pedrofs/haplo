angular.module('tccless').factory('User', ($resource) ->
  return $resource('/users/:id.json')
)