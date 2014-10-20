angular.module('tccless').factory 'ProjectData', [ ->
  projectData =
    currentProject: null
    projects: []
    add: (project) ->
      this.projects.push project
    remove: (id) ->
      result = []
      angular.forEach this.projects, (el) ->
        result.push el unless el.id == id

      this.projects = result

  projectData
]