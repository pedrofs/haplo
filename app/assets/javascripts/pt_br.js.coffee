angular.module('tccless').config ['$translateProvider', ($translateProvider) ->
  $translateProvider.translations 'pt-BR',
    Project: 'Projeto'
    Task: 'Tarefa'
 
  $translateProvider.preferredLanguage('pt-BR');
]