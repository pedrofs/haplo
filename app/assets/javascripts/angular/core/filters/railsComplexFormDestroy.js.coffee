angular.module('tccless').filter 'destroyed', [ ->
  (items) ->
    result = []
    angular.forEach items, (item, i) ->
      result.push(item) unless item._destroy

    result
]