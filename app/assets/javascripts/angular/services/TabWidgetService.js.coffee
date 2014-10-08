angular.module('tccless').provider 'TabWidgetService', [ ->
  tabs = new Object()

  this.createWidget = (widgetName) ->
        tabs[widgetName] = []

  this.addTab = (widgetName, tab) ->
    return false unless tabs[widgetName]

    tabs[widgetName].push tab

  this.$get = ->
    tabWidgetService =
      getTabs: (widgetName) ->
        tabs[widgetName] || false

    tabWidgetService

  return this
]