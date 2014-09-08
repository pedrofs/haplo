@tccless.factory 'UserService', ['User', (User) ->
  all = ->
    _self = this

    User.query().$promise.then (users) ->
      _self.users = users

  add = (user) ->
    this.users.push(user)

  obj =
    users: [],
    all: all,
    add: add

  obj
]