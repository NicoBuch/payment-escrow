$(document).ready ->

  $('#new-transaction-submit').click ->
    payer_id = $('#payer_id')[0].value
    receiver_id = $('#receiver_id')[0].value
    mediator_id = $('#mediator_id')[0].value
    satoshis = $('#satoshis')[0].value
    private_key = $('#private_key')[0].value
    if !(payer_id && receiver_id && mediator_id)
      $.growl.error message: "You need to select mediator and receiver"
    else
      publicKeys = [payer_id, receiver_id, mediator_id]
      requiredSignatures = 2
      bitcore = require('bitcore-lib')
      address = new bitcore.Address(publicKeys, requiredSignatures, bitcore.Networks.testnet)
      payer_address = new bitcore.PublicKey(payer_id).toAddress('testnet')
      Insight = require('bitcore-explorers').Insight
      insight = new Insight(bitcore.Networks.testnet)
      apiUrl = $(this).data().url
      insight.getUnspentUtxos(payer_address, (err, utxos) ->
        if err
          return $.growl.error message: 'Invalid Transaction'
        else
          totalUnspent = utxos.reduce((a,b) ->
            return a + b.satoshis
          , 0)
          if totalUnspent < parseInt(satoshis)
            return $.growl.error message: 'Invalid Transaction'
          else
            transaction = new bitcore.Transaction()
              .from(utxos)
              .to(address, parseInt(satoshis) - 10000)
              .change(payer_address)
              .fee(10000)
              .sign(private_key)
            insight.broadcast(transaction, (err, txid) ->
              if err
                return $.growl.error message: 'Invalid Transaction'
              else
                params = { payer_pk: payer_id, receiver_pk: receiver_id, mediator_pk: mediator_id, satoshis: satoshis, key: address.toString() }
                $.post(apiUrl, params, (data, status) ->
                  if status == 'success'
                    window.location.href = '/'
                  else
                    return $.growl.error message: 'Invalid Transaction'
                )
            )
      )

