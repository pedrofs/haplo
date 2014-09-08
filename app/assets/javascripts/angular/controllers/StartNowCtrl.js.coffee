@tccless.controller 'StartNowCtrl', [
  '$scope',
  '$location',
  'CreateAccountService',
  'FormBindService',
  ($scope, $location, createAccountService, FormBindService) ->
    $('body').addClass('login-layout light-login')

    $scope.createAccount = (account) ->
      formBind = new FormBindService()
      createAccountPromise = createAccountService.createAccount(account)
      formBind.bind($scope.accountForm, createAccountPromise)

      createAccountPromise.then ->
        window.location.href = "http://" + account.subdomain + ".lvh.me:3000/#/login"
]