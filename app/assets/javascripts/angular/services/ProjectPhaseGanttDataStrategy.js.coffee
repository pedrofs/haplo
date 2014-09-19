@tccless.factory 'ProjectPhaseGanttDataStrategy', ['md5', (md5) ->
  prepareData: (data) ->
    data.map (projectPhase, i) ->
      el =
        id: md5.createHash(projectPhase.name + 'phase')
        description: projectPhase.name
        tasks: [{
          id: md5.createHash(projectPhase.name + 'task')
          subject: projectPhase.name
          color: projectPhase.color
          from: projectPhase.start_at
          to: projectPhase.end_at 
        }]

      el
]