angular.module('tccless').factory 'RoleData', [ ->
  data =
    roles: []
    add: (role) ->
      this.roles.push role
    count: null
    remove: (id) ->
      result = []
      angular.forEach this.roles, (el) ->
        result.push el unless el.id == id

      this.roles = result

  data
]