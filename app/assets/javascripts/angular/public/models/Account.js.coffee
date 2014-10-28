angular.module('tccless').factory 'Account', ['$resource', ($resource) ->
  return $resource('/accounts.json')
]