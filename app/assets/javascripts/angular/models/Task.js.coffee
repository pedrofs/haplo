@tccless.factory('Task', ($resource) ->
  $resource('/tasks/:id.json')
)