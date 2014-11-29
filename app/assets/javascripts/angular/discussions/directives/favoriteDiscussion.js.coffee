angular.module('tccless').directive 'favoriteDiscussion', ['$http', 'FavoriteDiscussionData', ($http, FavoriteDiscussionData) ->
  directive =
    restrict: 'A'
    scope:
      discussion: '='
      favoriteCollection: '='
    link: (scope, element, attr) ->
      element.addClass "fa fa-bullseye ace-icon bigger-140"
      element.css {cursor:'pointer'}

      discussion = scope.discussion
      favoriteIds = FavoriteDiscussionData.discussions.map (discussion) -> discussion.id

      if discussion.id in favoriteIds
        element.addClass 'orange'

      element.bind 'click', (e) ->
        $http.post("/favorite_discussions/toggle/#{discussion.id}.json").then (response) ->
          if response.status == 204
            FavoriteDiscussionData.remove(discussion.id)
            element.removeClass 'orange'
          else if response.status == 201
            FavoriteDiscussionData.add(discussion)
            element.addClass 'orange'
]