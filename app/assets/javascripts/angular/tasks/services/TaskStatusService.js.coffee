angular.module('tccless').factory 'TaskStatusService', ['$http', ($http) ->
  find = (id) ->
    $http.get("/task_statuses/#{id}.json")

  all = () ->
    $http.get("/task_statuses.json")

  remove = (status) ->
    $http.delete("/task_statuses/#{status.id}.json")

  obj =
    find: find
    all: all
    remove: remove

  obj
]