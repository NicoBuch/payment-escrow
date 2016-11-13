class Transaction < ApplicationRecord
  belongs_to :address

  enum status: [:uninitialized, :pending, :needs_mediation, :completed, :cancelled]

  validates :address, :satoshis, presence: true

  delegate :payer, :receiver, :mediator, to: :address
end
