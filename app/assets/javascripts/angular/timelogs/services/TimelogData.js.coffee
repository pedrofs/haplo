angular.module('tccless').factory 'TimelogData', [ ->
  data =
    timelogs: []
    add: (timelog) ->
      this.timelogs.push timelog
    remove: (id) ->
      result = []
      angular.forEach this.timelogs, (el) ->
        result.push el unless el.id == id

      this.timelogs = result

  data
]