angular.module('tccless').factory 'TaskService', ['$http', ($http) ->
  find = (id) ->
    $http.get("/tasks/#{id}.json")

  all = (projectId) ->
    $http.get("/projects/#{projectId}/tasks.json")

  remove = (id) ->
    $http.delete("/tasks/#{id}.json")

  obj =
    find: find
    all: all
    remove: remove

  obj
]