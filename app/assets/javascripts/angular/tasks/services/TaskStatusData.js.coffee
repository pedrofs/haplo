angular.module('tccless').factory 'TaskStatusData', [ ->
  data =
    taskStatuses: []
    add: (status) ->
      this.taskStatuses.push status
    count: null
    remove: (id) ->
      result = []
      angular.forEach this.taskStatuses, (el) ->
        result.push el unless el.id == id

      this.taskStatuses = result

  data
]