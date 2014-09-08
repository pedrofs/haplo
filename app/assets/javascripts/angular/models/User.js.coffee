@tccless.factory('User', ($resource) ->
  return $resource('/users.json')
)