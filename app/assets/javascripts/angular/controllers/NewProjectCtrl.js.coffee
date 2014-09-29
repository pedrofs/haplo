angular.module('tccless').controller 'NewProjectCtrl', [
  '$scope',
  '$http',
  '$filter',
  'ProjectService',
  'FormBindService',
  'Project',
  'WizardService',
  'GanttController',
  'ProjectPhaseGanttDataStrategy'
  'md5'
  ($scope, $http, $filter, ProjectService, FormBindService, Project, WizardService, GanttController, ProjectPhaseGanttDataStrategy, md5) ->
    $scope.project = {name: null}

    $scope.opts =
      applyClass: 'btn-sm btn-primary'
      cancelClass: 'btn-sm btn-default pull-right'
      format: 'DD/MM/YYYY'
      locale:
        applyLabel: 'Aplicar'
        cancelLabel: 'Cancelar'
        fromLabel: 'DE'
        toLabel: 'ATÉ'

    $scope.projectPhase =
      range:
        startDate: null
        endDate: null

    ganttController = new GanttController()
    ganttController.setDataStrategy(ProjectPhaseGanttDataStrategy)

    $scope.cancel = ->
      $scope.$dismiss('canceled')

    $scope.createProject = (form) ->
      formBind = new FormBindService()

      project = new Project({project: $scope.project})
      creationPromisse = project.$save()

      formBind.bind(form, creationPromisse)

      creationPromisse.then (project) ->
        ProjectService.add(project)
        $scope.$dismiss('created')

      creationPromisse.catch (response) ->
        if response.status == 422
          WizardService.reset()

    $scope.projectPhaseFactory = (projectPhase) ->
      return {
        name: projectPhase.name
        start_at: $filter('date')(projectPhase.range.startDate, 'yyyy-MM-dd')
        end_at: $filter('date')(projectPhase.range.endDate, 'yyyy-MM-dd')
        color: projectPhase.color
      }

    $scope.changedCallback = (projectPhase) ->
      $scope.renderProjectPhases()

    $scope.validateProjectPhase = (projectPhase) ->
      projectPhase && projectPhase.range && projectPhase.range.startDate && this.validateUniquenessName(projectPhase)

    $scope.validateUniquenessName = (projectPhase) ->
      valid = true

      angular.forEach $scope.project.project_phases_attributes, (phase) ->
        valid = false if phase.name == projectPhase.name && not phase._destroy

      valid

    $scope.renderProjectPhases = ->
      data = $scope.project.project_phases_attributes.filter (e) -> !e._destroy

      ganttController.load data

    $scope.setGanttLoad = (loader) ->
      ganttController.setGanttLoad loader

    $scope.setGanttClear = (clear) ->
      ganttController.setGanttClear clear

    $scope.setRemoveProjectPhase = (removeProjectPhase) ->
      $scope.removeProjectPhase = removeProjectPhase
]
