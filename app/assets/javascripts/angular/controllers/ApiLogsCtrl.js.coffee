@tccless.controller 'ApiLogsCtrl', [
  '$scope',
  'ApiLogService',
  ($scope, ApiLogService) ->
    $scope.apiLogService = ApiLogService

    ApiLogService.load()
]