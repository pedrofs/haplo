@tccless.factory 'ProjectService', ['Project', (Project) ->
  all = ->
    _self = this

    Project.query().$promise.then (projects) ->
      _self.projects = projects

  add = (project) ->
    this.projects.push(project)

  remove = (projectId) ->
    newProjects = []

    angular.forEach this.projects, (project) ->
      newProjects.push(project) if project.id != projectId

    this.projects = newProjects

  save = (project) ->

  destroy = (projectId) ->
    _self = this
    Project.remove({id: projectId}).$promise.then (response) ->
      _self.remove(projectId)

  obj =
    projects: [],
    all: all,
    add: add,
    remove: remove,
    save: save,
    destroy: destroy

  obj
]