@tccless.factory('Account', ($resource) ->
  return $resource('/accounts.json')
)