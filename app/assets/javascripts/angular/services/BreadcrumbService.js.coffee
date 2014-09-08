@tccless.factory 'BreadcrumbService', ->
  obj =
    items: [],
    addItem: (item) ->
      this.items.push(item)
    ,reset: ->
      this.items = ['Home']

  obj.reset()

  obj