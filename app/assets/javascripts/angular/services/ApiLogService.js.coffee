angular.module('tccless').factory 'ApiLogService', ['SessionService', (SessionService) ->
  service =
    loading: false
    total: 0
    current: 0
    logs: []
    source: null
    load: null

  onCountingCallback = (e) ->
    console.log JSON.parse(e.data)

  onProgressCallback = (e) ->
    console.log JSON.parse(e.data).progress

  onCompleteCallback = (callback) ->
    (e) ->
      service.source.close() if service.source
      service.loading = false
      callback(JSON.parse(e.data).api_logs)

  service.load = (callback) ->
      return if this.loading

      this.loading = true

      userEmail = SessionService.currentUser.email
      userToken = SessionService.currentUser.authentication_token

      this.source = new EventSource "/api_logs?user_email=#{userEmail}&user_token=#{userToken}"
      this.source.addEventListener 'progress', onProgressCallback, false
      this.source.addEventListener 'complete', onCompleteCallback(callback), false

  service
]