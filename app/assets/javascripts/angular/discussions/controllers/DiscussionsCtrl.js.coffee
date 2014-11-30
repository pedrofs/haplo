angular.module('tccless').controller 'DiscussionsCtrl', [
  '$scope'
  'BreadcrumbService'
  'TitleService'
  'DiscussionData'
  ($scope, BreadcrumbService, TitleService, DiscussionData) ->
    configureView = ->
      BreadcrumbService.use 'discussions'
      TitleService.setTitle 'Minhas Discussões'
      TitleService.setDescription 'A lista de suas discussões favoritas'

    configureView()

    console.log DiscussionData.discussions
]