@tccless.factory('Project', ($resource) ->
  return $resource('/projects/:id.json')
)