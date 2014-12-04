angular.module('tccless').controller 'ObjectDiscussionsCtrl', [
  '$scope'
  'DiscussionData'
  ($scope, DiscussionData) ->
    $scope.DiscussionData = DiscussionData
]