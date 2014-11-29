angular.module('tccless').directive 'newDiscussion', [->
  directive =
    restrict: 'A'
    templateUrl: 'templates/discussions/new.html'
    link: (scope, element, attrs) ->
      initButton = element.find('button').first()
      createButton = element.find('button').last()

      element.find('.cancel').click ->
        $('#discussion_content').slideUp ->
          scope.$apply ->
            scope.discussion.content = ''

          initButton.show()

      initButton.click ->
        $(this).hide()
        $('#discussion_content').slideDown()

      createButton.click ->
        console.log scope.targetableId
        console.log scope.targetableType
        console.log scope.discussion
]