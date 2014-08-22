@tccless.factory 'CreateAccountService', ['Account', (Account) ->
  createAccount = (account) ->
    accountResource = new Account({account: account})
    return accountResource.$save()

  return {
    createAccount: createAccount
  }
]