angular.module('tccless').factory 'UserService', ['User', (User) ->
  all = ->
    _self = this

    User.query().$promise.then (users) ->
      _self.users = users

  add = (user) ->
    this.users.push(user)

  remove = (userId) ->
    newUsers = []

    angular.forEach this.users, (user) ->
      newUsers.push(user) if user.id != userId

    this.users = newUsers

  save = (user) ->

  destroy = (userId) ->
    _self = this
    User.remove({id: userId}).$promise.then (response) ->
      _self.remove(userId)

  obj =
    users: [],
    all: all,
    add: add,
    remove: remove,
    save: save,
    destroy: destroy

  obj
]