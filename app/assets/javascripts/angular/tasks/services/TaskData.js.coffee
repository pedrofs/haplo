angular.module('tccless').factory 'TaskData', [ ->
  taskData =
    tasks: []
    add: (task) ->
      this.tasks.push task
    count: null
    remove: (id) ->
      result = []
      angular.forEach this.tasks, (el) ->
        result.push el unless el.id == id

      this.tasks = result

  taskData
]