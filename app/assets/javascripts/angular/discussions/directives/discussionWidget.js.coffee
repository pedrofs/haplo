angular.module('tccless').directive 'discussionWidget', [->
  directive =
    restrict: 'E'
    templateUrl: 'templates/discussions/widget.html'
    scope:
      targetableId: '@'
      targetableType: '@'
      userId: '@'
      createDiscussion: '='
    link: (scope, element, attrs) ->
      options =
        size: 400
        mouseWheelLock: true
        alwaysVisible : true
      $('#profile-feed-1').ace_scroll options

    controller: ['$scope', '$http', 'DiscussionData', 'FavoriteDiscussionData', ($scope, $http, DiscussionData, FavoriteDiscussionData) ->
      query = ''
      if $scope.targetableId and $scope.targetableType
        query = "?targetable_id=#{$scope.targetableId}&targetable_type=#{$scope.targetableType}"
      else if $scope.userId
        query = "?user_id=#{$scope.userId}"

      $http.get("/discussions.json#{query}").then (response) ->
        DiscussionData.discussions = response.data

      $http.get("/favorite_discussions.json").then (response) ->
        FavoriteDiscussionData.discussions = response.data

      $scope.FavoriteDiscussionData = FavoriteDiscussionData
      $scope.DiscussionData = DiscussionData
      $scope.paginationConfig =
        limit: 5
        perPage: 5
    ]
]