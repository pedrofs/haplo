angular.module('tccless').controller 'NewRoleCtrl', [
  '$scope'
  '$http'
  'FormBindService'
  'RoleData'
  ($scope, $http, FormBindService, RoleData) ->
    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createRole = (form) ->
      formBind = new FormBindService()

      creationPromisse = $http.post("/roles.json", {role: $scope.role})

      formBind.bind(form, creationPromisse)

      creationPromisse.then (response) ->
        console.log response
        console.log RoleData
        RoleData.add(response.data)
        $scope.$dismiss('created')

    $scope.role = {}
]
