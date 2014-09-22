@tccless.factory 'TitleService', ->
  obj =
    title: ''
    description: ''
    setTitle: (title) ->
      this.title = title
    setDescription: (description) ->
      this.description = description

  obj