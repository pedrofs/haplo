angular.module('tccless').directive 'favoriteProjectStar', ['$http', 'FavoriteProjectData', ($http, FavoriteProjectData) ->
  directive =
    restrict: 'A'
    scope:
      project: '='
      favoriteCollection: '='
    link: (scope, element, attr) ->
      element.addClass "fa fa-star ace-icon bigger-140"
      element.css {cursor:'pointer'}

      project = scope.project
      favoriteIds = FavoriteProjectData.favoriteProjects.map (project) -> project.id

      if project.id in favoriteIds
        element.addClass 'orange'

      element.bind 'click', (e) ->
        $http.post("/favorite_projects/toggle/#{project.id}.json").then (response) ->
          if response.status == 204
            FavoriteProjectData.remove(project.id)
            element.removeClass 'orange'
          else if response.status == 201
            FavoriteProjectData.add(project)
            element.addClass 'orange'
]