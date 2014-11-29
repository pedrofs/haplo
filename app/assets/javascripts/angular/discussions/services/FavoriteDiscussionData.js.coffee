angular.module('tccless').factory 'FavoriteDiscussionData', [ ->
  discussionData =
    discussions: []
    unshift: (discussion) ->
      this.discussions.unshift discussion
    add: (discussion) ->
      this.discussions.push discussion
    remove: (id) ->
      result = []
      angular.forEach this.discussions, (el) ->
        result.push el unless el.id == id

      this.discussions = result

  discussionData
]