angular.module('tccless').factory 'TaskService', ['$http', ($http) ->
  find = (id) ->
    $http.get("/tasks/#{id}.json")

  all = (projectId) ->
    $http.get("/projects/#{projectId}/tasks.json")

  obj =
    find: find
    all: all

  obj
]