$(document).ready ->
  $('#save-initialized-transaction').click ->
    private_key = $('#private_key')[0].value
    address_key = $('#address_key')[0].value
    receiver_public_key = $('#receiver_public_key')[0].value
    payer_public_key = $('#payer_public_key')[0].value
    mediator_public_key = $('#mediator_public_key')[0].value
    satoshis = $('#satoshis')[0].value
    Insight = require('bitcore-explorers').Insight
    bitcore = require('bitcore-lib')
    insight = new Insight(bitcore.Networks.testnet)
    apiUrl = $(this).data().url
    insight.getUnspentUtxos(address_key, (err, utxos) ->
      if err
        return $.growl.error message: 'Invalid Transaction'
      else
        receiver_address = new bitcore.PublicKey(receiver_public_key).toAddress('testnet')
        transaction = new bitcore.Transaction()
          .from(utxos, [receiver_public_key, payer_public_key, mediator_public_key], 2)
          .to(receiver_address, parseInt(satoshis) - 20000)
          .change(address_key)
        transaction.fee(transaction.getFee()).sign(private_key)
        $.post(apiUrl, { serialization: JSON.stringify(transaction) }, (data, status) ->
          if status == 'success'
            window.location.href = '/'
          else
            return $.growl.error message: 'Invalid Transaction'
        )
    )





