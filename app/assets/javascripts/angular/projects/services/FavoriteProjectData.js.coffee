angular.module('tccless').factory 'FavoriteProjectData', [ ->
  data =
    currentFavoriteProject: null
    favoriteProjects: []
    add: (favoriteProject) ->
      this.favoriteProjects.push favoriteProject
    remove: (id) ->
      result = []
      angular.forEach this.favoriteProjects, (el) ->
        result.push el unless el.id == id

      this.favoriteProjects = result

  data
]