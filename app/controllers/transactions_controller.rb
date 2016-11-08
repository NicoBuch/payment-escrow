class TransactionsController < ApplicationController

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = Transaction.new
    @mediators = User.where(mediator: true)
    @users = User.where(mediator: false).where.not(id: current_user.id)
  end

  def create
    address = find_or_initialize_address(address_params)
    return head :bad_request unless address.save && transaction_params[:satoshis].to_i > 0
    Transaction.create(transaction_params.merge(address_id: address.id))
    head :ok
  end

  private

  def transaction_params
    params.permit(:satoshis)
  end

  def address_params
    params.permit(:key, :receiver_pk, :payer_pk, :mediator_pk)
  end

  def find_or_initialize_address(parameters)
    receiver = User.find_by_public_key(parameters[:receiver_pk])
    payer = User.find_by_public_key(parameters[:payer_pk])
    mediator = User.find_by_public_key(parameters[:mediator_pk])
    return unless [receiver, payer, mediator].all? { |user| user.present? }
    Address.find_or_initialize_by(
      receiver: receiver, payer: payer, mediator: mediator, key: parameters[:key]
    )
  end
end
