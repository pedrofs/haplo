angular.module('tccless').controller 'DiscussionViewCtrl', [
  '$scope'
  '$http'
  'DiscussionData'
  'SessionService'
  ($scope, $http, DiscussionData, SessionService) ->
    $scope.cancel = ->
      $scope.$dismiss()

    $scope.createComment = ->
      $http.post('/comments.json', {comment: $scope.comment}).then (response) ->
        DiscussionData.currentDiscussion.comments.push response.data.comment
        $scope.comment.content = ''

    $scope.discussion = DiscussionData.currentDiscussion
    $scope.comment = {discussion_id: DiscussionData.currentDiscussion.id}
]