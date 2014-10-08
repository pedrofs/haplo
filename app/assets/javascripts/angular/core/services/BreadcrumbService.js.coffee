angular.module('tccless').provider 'BreadcrumbService', ->
  breadcrumbs = {}

  this.addBreadcrumb = (name, breadcrumb) ->
      breadcrumbs[name] = breadcrumb

  process = (breadcrumb) ->
    return [breadcrumb] unless breadcrumb.dependency
    throw new Error("Breadcrumb dependency not found: #{breadcrumb.dependency}") unless dependency = breadcrumbs[breadcrumb.dependency]
    return process(dependency).concat [breadcrumb]

  this.$get = ->
    service =
      items: []
      use: (breadcrumb, params = {}) ->
        throw new Error("Breadcrumb not found: #{breadcrumb}.") unless breadcrumbs[breadcrumb]

        breadcrumbs[breadcrumb] = angular.extend(breadcrumbs[breadcrumb], params)
        this.items = process(breadcrumbs[breadcrumb])
        console.log this.items

    service

  return this