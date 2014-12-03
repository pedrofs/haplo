angular.module('tccless').directive 'markAsToday', ['$http', 'TaskData', ($http, TaskData) ->
  directive =
    restrict: 'A'
    scope:
      task: '='
    link: (scope, element, attr) ->
      element.addClass "ace-icon fa-bolt fa bigger-180"
      element.css {cursor:'pointer'}

      task = scope.task

      if task.today
        element.addClass 'orange'

      element.bind 'click', (e) ->
        attr =
          today: !task.today

        $http.put("/tasks/#{task.id}.json", {task: attr}).then (response) ->
          if response.data.task.today
            task.today = true
            element.addClass 'orange'
          else
            task.today = false
            element.removeClass 'orange'
]