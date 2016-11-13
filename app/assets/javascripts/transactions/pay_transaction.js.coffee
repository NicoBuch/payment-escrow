$(document).ready ->
  $('#complete-transaction').click ->
    private_key = $('#private_key')[0].value
    transaction_serialized = $('#transaction_serialized')[0].value
    Insight = require('bitcore-explorers').Insight
    bitcore = require('bitcore-lib')
    insight = new Insight(bitcore.Networks.testnet)
    apiUrl = $(this).data().url
    transaction = new bitcore.Transaction(JSON.parse(transaction_serialized))
    transaction.sign(private_key)
    if !transaction.isFullySigned()
      return $.growl.error message: 'Missing Signatures'
    else
      insight.broadcast(transaction, (err, txid) ->
        if err
          return $.growl.error message: 'Invalid Transaction'
        else
          params = { serialization: JSON.stringify(transaction) }
          $.post(apiUrl, params, (data, status) ->
            if status == 'success'
              window.location.href = '/'
            else
              return $.growl.error message: 'Invalid Transaction'
          )
      )


