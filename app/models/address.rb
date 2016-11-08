class Address < ApplicationRecord
  belongs_to :payer, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :mediator, class_name: 'User'

  validates :payer, :receiver, :mediator, :key, presence: true
  validates :payer_id, uniqueness: { scope: [:receiver_id, :mediator_id] }
  validates :key, uniqueness: true

  validate :valid_mediator

  private

  def valid_mediator
    errors.add('Invalid Mediator') unless mediator.mediator?
  end
end
