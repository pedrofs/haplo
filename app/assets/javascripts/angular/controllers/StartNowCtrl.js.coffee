@tccless.controller 'StartNowCtrl', ['$scope', '$http', 'CreateAccountService', 'FormBindService', ($scope, $http, createAccountService, FormBindService) ->
  $('body').addClass('login-layout light-login')

  $scope.createAccount = (account) ->
    formBind = new FormBindService()
    createAccountPromise = createAccountService.createAccount(account)
    formBind.bind($scope.accountForm, createAccountPromise)
]