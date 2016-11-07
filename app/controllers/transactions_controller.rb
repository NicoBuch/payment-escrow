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
    address = Address.find_by(address_params)
    render_errors('Address not found. Please try again', new_transaction_path) if address.nil?
    Transaction.create(transaction_params.merge(address_id: address.id))
    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:satoshis)
  end

  def address_params
    params.require(:transaction).permit(:key)
  end
end
