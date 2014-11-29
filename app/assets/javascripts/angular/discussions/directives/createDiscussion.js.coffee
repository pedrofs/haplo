angular.module('tccless').directive 'newDiscussion', ['$http', 'DiscussionData', ($http, DiscussionData)->
  directive =
    restrict: 'A'
    templateUrl: 'templates/discussions/new.html'
    link: (scope, element, attrs) ->
      initButton = element.find('button').first()
      createButton = element.find('button').last()
      cancelButton = element.find('.cancel').first()

      cancel = ->
        $('#discussion_content').slideUp ->
          scope.$apply ->
            scope.discussion.content = ''

          initButton.show()

      cancelButton.click cancel

      initButton.click ->
        $(this).hide()
        $('#discussion_content').slideDown()

      createButton.click ->
        data =
          discussion: scope.discussion
          targetable_id: scope.targetableId
          targetable_type: scope.targetableType

        $http.post('/discussions.json', data).then (response) ->
          DiscussionData.add response.data.discussion
          cancel()

]