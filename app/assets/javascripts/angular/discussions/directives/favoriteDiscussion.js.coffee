angular.module('tccless').directive 'favoriteDiscussion', ['$http', 'DiscussionData', ($http, DiscussionData) ->
  directive =
    restrict: 'A'
    scope:
      discussion: '='
      favoriteCollection: '='
    link: (scope, element, attr) ->
      element.addClass "fa fa-bullseye ace-icon bigger-140"
      element.css {cursor:'pointer'}

      discussion = scope.discussion
      favorites = DiscussionData.discussions.filter (discussion) -> discussion.favorite
      favoriteIds = favorites.map (discussion) -> discussion.id

      if discussion.id in favoriteIds
        element.addClass 'orange'

      element.bind 'click', (e) ->
        $http.post("/favorite_discussions/toggle/#{discussion.id}.json").then (response) ->
          if response.status == 204
            element.removeClass 'orange'
            if attr.removeFrom
              DiscussionData.remove(discussion.id)
          else if response.status == 201
            element.addClass 'orange'
]