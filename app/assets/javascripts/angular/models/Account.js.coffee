angular.module('tccless').factory('Account', ($resource) ->
  return $resource('/accounts.json')
)