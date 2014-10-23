angular.module('tccless').factory 'RoleService', ['$http', ($http) ->
  find = (id) ->
    $http.get("/roles/#{id}.json")

  all = ->
    $http.get("/roles.json")

  remove = (id) ->
    $http.delete("/roles/#{id}.json")

  obj =
    find: find
    all: all
    remove: remove

  obj
]