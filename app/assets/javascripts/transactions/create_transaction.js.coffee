$(document).ready ->

  $('#new-transaction-submit').click ->
    payer_id = $('#payer_id')[0].value
    receiver_id = $('#receiver_id')[0].value
    mediator_id = $('#mediator_id')[0].value
    satoshis = $('#satoshis')[0].value
    if !(payer_id && receiver_id && mediator_id)
      $.growl.error message: "You need to select mediator and receiver"
    else
      publicKeys = [payer_id, receiver_id, mediator_id]
      requiredSignatures = 2
      bitcore = require('bitcore-lib')
      address = new bitcore.Address(publicKeys, requiredSignatures)
      params = { payer_pk: payer_id, receiver_pk: receiver_id, mediator_pk: mediator_id, satoshis: satoshis, key: address.toString() }
      $.post($(this).data().url, params, ->
        window.location.href = '/'
      ).fail ->
        $.growl.error message: 'Invalid Transaction'
