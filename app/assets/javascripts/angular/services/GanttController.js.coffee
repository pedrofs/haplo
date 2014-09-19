class GanttController
  constructor: ->
    @ganttLoad = null
    @ganttClear = null
    @dataStrategy = null

  setGanttLoad: (loader) ->
    @ganttLoad = loader

  setGanttClear: (clear) ->
    @ganttClear = clear

  setDataStrategy: (dataStrategy) ->
    @dataStrategy = dataStrategy

  load: (data) ->
    preparedData = @dataStrategy.prepareData(data)

    @ganttClear()
    @ganttLoad(preparedData)

@tccless.factory 'GanttController', [ ->
  GanttController
]