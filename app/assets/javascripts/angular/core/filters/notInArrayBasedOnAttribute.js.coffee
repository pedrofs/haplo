angular.module('tccless').filter 'notInArrayBasedOnAttribute', [->
  (sourceArray, secondaryArray, attribute) ->
    mapToRemove = secondaryArray.map (el) -> el[attribute]

    sourceArray.filter (sourceElement) ->
      if sourceElement[attribute] in mapToRemove then false else true
]