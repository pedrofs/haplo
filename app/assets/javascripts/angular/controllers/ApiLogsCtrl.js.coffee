@tccless.controller 'ApiLogsCtrl', [
  '$scope',
  '$modal',
  'BreadcrumbService',
  'TitleService',
  'ApiLogService',
  'ApiLogData',
  ($scope, $modal, BreadcrumbService, TitleService, ApiLogService, ApiLogData) ->
    configureView = ->
      BreadcrumbService.reset()
      BreadcrumbService.addItem('API Logs')
      TitleService.setTitle('API Logs')
      TitleService.setDescription('Audição de todas as requisições feitas.')

    configureView()

    ApiLogService.load (apiLogs) ->
      $scope.$apply ->
        ApiLogData.apiLogs = apiLogs

    $scope.ApiLogData = ApiLogData

    $scope.openDetail = (detail) ->
      if detail
        detail = JSON.stringify(JSON.parse(detail), undefined, 2)
        body = "<pre>#{detail}</pre>"
      else
        body = "<em>não há parâmetros</em>"

      template = 
        "<div class=\"modal-header\"><h3>Parâmetros</h3></div><div class=\"modal-body\">#{body}</div>"

      config =
        template: template

      $modal.open config
]