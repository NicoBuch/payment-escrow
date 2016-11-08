class Transaction < ApplicationRecord
  belongs_to :address

  enum status: [:pending, :completed, :cancelled]

  validates :address, :satoshis, presence: true

  delegate :payer, :receiver, :mediator, to: :address
end
